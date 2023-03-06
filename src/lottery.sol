// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.18;

contract Lottery {
    // Slot 0
    mapping(address player => bytes32 numbers) public playerNumbers;

    // The F at 0 position is there to stop the state from resetting to zero. 
    // If this happens, it will cost 21k+Gas to reinit to a positive integer.
    // numbers start from 1 and go to 63..
    /*
                     0123456789...                                               ...63*/
    bytes32 base = 0xF000000000000000000000000000000000000000000000000000000000000000; // slot 1

    //slot 2 - 0xFF00F0F00000000000000000000000000F0000000000F000000000000000000F
    bytes32 public winningNumbers =
        0xF000000000000000000000000000000000000000000000000000000000000000;

    // Mock numbers to demo.
    uint256[] public _winningNumbers = [1, 4, 6, 33, 44, 63];

    /// @dev PlaceHolder to add an array of numbers to bytes32 map.
    /// Should come from a trusted VRF
    function addWinningNumbers() public {
        _addNumbersToBytes(_winningNumbers);
    }

    /// @dev Reset numbers to 0.
    /// Should come from a trusted VRF
    function resetWinningNumbers() public {
        winningNumbers = base;
    }

    /// @dev adds a bytes string of number locations.
    /// Iterates over positions 1-63 to check that 6 positions exist.
    /// @param numbersBytes bytes with selected number position as 'F'
    /// Example - 0xFF00F0F00000000000000000000000000F0000000000F000000000000000000F
    function addPlayerNumbers(address player, bytes32 numbersBytes) public {
        // Hash Key (player) and slot (0)
        bytes32 location = keccak256(abi.encode(player, 0x0));

        assembly {
            let counter := 0
            for {
                let i := 1
            } lt(i, 64) {
                i := add(i, 1)
            } {
                // Shift the 'on' bit (F) to the correct position
                let shifted := shr(mul(i, 4), sload(base.slot))

                // AND to create a new state
                let anded := and(numbersBytes, shifted)

                // check if equal.
                if eq(anded, shifted) {
                    counter := add(counter, 1)
                } // increment counter by 1}

                if eq(6, counter) {
                    // We hit 6? -> store to mapping
                    sstore(location, numbersBytes)
                    break
                }
            }
        }
    }

    function _addNumbersToBytes(uint256[] memory arr) public {
        // the short version...
        // bytes32 shifted = base >> pos * 4;
        // return state ^ shifted;

        assembly {
            // where array is stored in memory (0x80)
            let location := arr

            // length of array
            let length := mload(arr)

            for {
                let i := 0
            } lt(i, length) {
                i := add(i, 1)
            } {
                // Load current state
                let state := sload(winningNumbers.slot)

                // load item from the Array
                // arr[i], data offset = 0x20 (1st 32 is reserved for size) & i*32 (0x20) to pickup the right index
                let item := mload(add(arr, add(0x20, mul(i, 0x20))))

                // Calculate the position in hex
                let bit_pos := mul(item, 4)

                // Shift the 'on' bit (F) to the correct position
                let shifted := shr(bit_pos, sload(base.slot))

                // XOR to create a new state
                let xored := xor(state, shifted)

                // update the variable
                sstore(winningNumbers.slot, xored)
            }
        }
    }

    function checkWinner(address player) public returns (bool result) {
        bytes32 _playerNumbers = keccak256(abi.encode(player, 0x0)); //slot 0
        assembly {
            let state := sload(_playerNumbers)
            result := eq(and(sload(winningNumbers.slot), state), state)
        }
    }
}
