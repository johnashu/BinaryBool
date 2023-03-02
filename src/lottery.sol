// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.18;

contract Lottery {
    // Slot 0
    mapping(address player => bytes32 numbers) public playerNumbers;

    // 0 is there to stop the state from resetting to zero. If this happens, it will cost 21k+Gas to reinit to a positive integer.

    // numbers start from 1 and go to 63..
    /*
                     0123456789...                                               ...63*/
    bytes32 base = 0xF000000000000000000000000000000000000000000000000000000000000000;
    bytes32 full = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;

    bytes32 public winningNumbers = 0xF000000000000000000000000000000000000000000000000000000000000000;

    /// @dev adds a bytes string of number locations
    /// @param numbersBytes bytes with selected number position as 'F'
    /// Example - 0xFF00F0F00000000000000000000000000F0000000000F000000000000000000F
    function addPlayerNumbers(address player, bytes32 numbersBytes) public {
        // Hash Key (player) and slot (2)
        bytes32 location = keccak256(abi.encode(player, 0x0));

        assembly {
            sstore(location, numbersBytes)
        }
    }

    function addWinningNumbers() public {
        // 0xFF00F0F00000000000000000000000000F0000000000F000000000000000000F
        uint8[6] memory _winningNumbers = [1, 4, 6, 33, 44, 63];
        for (uint256 i = 0; i < _winningNumbers.length; i++) {
            addNumbersToBytes(_winningNumbers[i]);
        }
    }

    function addNumbersToBytes(uint8 pos) private {
        bytes32 shifted = base >> pos * 4;
        winningNumbers = winningNumbers ^ shifted;

        // assembly {
        //         let state := sload(winningNumbers.slot)
        //         let bit_pos := mul(4,pos)
        //         let shifted := shr(0xF000000000000000000000000000000000000000000000000000000000000000, bit_pos)
        //         sstore(winningNumbers.slot, xor(state, shifted))
        //     }
    }

    function checkWinner(address player, bytes32 winningNums) public returns (bool result) {
        bytes32 playerNumbers = keccak256(abi.encode(player, 0));

        assembly {
            let state := sload(playerNumbers)
            result := eq(and(winningNums, state), state)
        }
    }

    function _exists(bytes32 state, uint8 pos) public returns (bool newState) {
        assembly {
            let shifted := shr(0xF000000000000000000000000000000000000000000000000000000000000000, mul(pos, 4))
            let anded := and(state, shifted)
            newState := eq(anded, shifted)
        }
    }
}
