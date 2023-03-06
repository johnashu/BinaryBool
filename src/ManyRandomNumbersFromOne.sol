// SPDX-License-Identifier: SEE LICENSE IN LICENSE

// Maffaz 2023

pragma solidity 0.8.18;

//  forge test for 1 play fuzzed 10k
// | src/ManyRandomNumbersFromOne.sol:ManyRandomNumbersFromOne    |                 |      |        |      |         |
// |--------------------------------------------------------------|-----------------|------|--------|------|---------|
// | Function Name                                                | min             | avg  | median | max  | # calls |
// | manyRandomPlays                                              | 826             | 826  | 826    | 826  | 1       |
// | manyRandomPlaysNormal                                        | 1295            | 1295 | 1295   | 1295 | 1       |

//  forge test for 64 plays fuzzed 10k
// | src/ManyRandomNumbersFromOne.sol:ManyRandomNumbersFromOne |                 |       |        |       |         |
// |-----------------------------------------------------------|-----------------|-------|--------|-------|---------|
// | Function Name                                             | min             | avg   | median | max   | # calls |
// | manyRandomPlays                                           | 6874            | 6874  | 6874   | 6874  | 1       |
// | manyRandomPlaysNormal                                     | 30017           | 30017 | 30017  | 30017 | 1       |

contract ManyRandomNumbersFromOne {
    error TooManyOrZeroplays();
    /// @dev iterates over 1 x 32 byte word using the 'plays' passed and returns the number of winning outcomes from that iteration.
    /// @param plays number of plays (up to 64 we can execute with looking at numbers 1-16 (result + 1)
    ///              We need to half that for each hex added - 0x10 - 0xff = max 32 (numbers 1-256) ... )
    /// @return numberWins number of times this user has won.

    function manyRandomPlays(uint256 plays) public returns (uint256 numberWins) {
        // Mock value but should be a 32 byte VRF from a trusted source on chain or oracle.
        uint256 randomNumber = uint256(
            keccak256(abi.encodePacked(block.timestamp * block.number, msg.sender, block.timestamp + block.number))
        );
        // Check here that the amount does not exceed 64
        if (plays > 64 || plays == 0) revert TooManyOrZeroplays();

        assembly {
            let winningNumber := 2 // We will do a simple random toss here with 2 outcomes [1] lose [2] win but any number can be used.
            for { let i := 0 } lt(i, plays) { i := add(i, 1) } {

                // Shift the 'on' bit (F) to the correct position
                let shifted := shr(mul(i, 4), randomNumber)

                // check if winner using modulo to find a winning number.
                if eq(mod(shifted, winningNumber), 0) { numberWins := add(numberWins, 1) } // increment counter by 1
            }
        }
    }

    /// @dev Normal solidity implementation of a play
    /// @param plays number of plays
    /// @return numberWins Whether the player wins or loses the play..
    function manyRandomPlaysNormal(uint256 plays) public returns (uint256 numberWins) {
        // Check here that the amount does not exceed the
        if (plays > 64 || plays == 0) revert TooManyOrZeroplays();

        // Mock value but should be a 32 byte VRF from a trusted source on chain or oracle.
        uint256 randomNumber = uint256(
            keccak256(abi.encodePacked(block.timestamp * block.number, msg.sender, block.timestamp + block.number))
        );
        uint8 winningNumber = 2;

        // 64 times we can divide by 10 to get 64 unique numbers to play.
        uint256 maxDiv = 10000000000000000000000000000000000000000000000000000000000000000;

        // we have to start from 1 as we cannot divide by zero..
        // We have to take of the last digit 1 at a time using division.
        for (uint256 i = 1; i < plays + 1; ++i) {
            randomNumber = randomNumber / maxDiv;
            if (randomNumber % 2 == 0) {
                ++numberWins;
            }
            maxDiv /= 10;
        }
    }
}
