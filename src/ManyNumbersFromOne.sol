// SPDX-License-Identifier: SEE LICENSE IN LICENSE

// Maffaz 2023

pragma solidity 0.8.18;


// | src/ManyRandomNumbersFromOne.sol:ManyRandomNumbersFromOne contract |                 |     |        |     |         |
// |--------------------------------------------------------|-----------------|-----|--------|-----|---------|
// | Deployment Cost                                        | Deployment Size |     |        |     |         |
// | 86535                                                  | 464             |     |        |     |         |
// | Function Name                                          | min             | avg | median | max | # calls |
// | manyCoinPlays                                          | 677             | 758 | 758    | 840 | 2       |

contract ManyRandomNumbersFromOne {
    error TooManyOrZeroplays();
    /// @dev iterates over 1 x 32 byte word using the 'plays' passed and returns the number of winning outcomes from that iteration.
    /// @param plays number of plays (up to 64 we can execute with looking at numbers 1-16 (result + 1)
    ///              We need to half that for each hex added - 0x10 - 0xff = max 32 (numbers 1-256) ... )
    /// @return numberWins number of times this user has won.

    function manyCoinPlays(uint256 plays) public returns (uint256 numberWins) {
        // Mock value but should be a 32 byte VRF from a trusted source on chain or oracle.  
        uint256 randomNumber = uint256(
            keccak256(abi.encodePacked(block.timestamp * block.number, msg.sender, block.timestamp + block.number))
        );
        // Check here that the amount does not exceed the
        if (plays > 64 || plays == 0) revert TooManyOrZeroplays();
        assembly {
            let winningNumber := 2 // We will do a simple coin toss here with 2 outcomes [1] lose [2] win but any number can be used
            for { let i := 1 } lt(i, plays) { i := add(i, 1) } {
                // Shift the 'on' bit (F) to the correct position
                let shifted := shr(mul(i, 4), randomNumber)

                // check if winner using modulo to find a winning number.
                if eq(mod(shifted, winningNumber), 0) { numberWins := add(numberWins, 1) } // increment counter by 1
            }
        }
    }
}
