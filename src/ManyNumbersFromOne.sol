// SPDX-License-Identifier: SEE LICENSE IN LICENSE

// Maffaz 2023

pragma solidity 0.8.18;

contract ManyNumbersFromOne {
    error TooManyOrZeroFlips();
    /// @dev iterates over a 32 byte word using the 'flips' passed and returns the number of winning outcomes from that iteration.
    /// @param flips number of flips (up to 64 we can execute with looking at numbers 1-16 (result + 1)
    ///              We need to half that for each hex added - 0x10 - 0xff = max 32 ... )
    /// @return numberWins number of times this user has won.

    function manyCoinFlips(uint256 flips) public returns (uint256 numberWins) {
        uint256 randomNumber = uint256(
            keccak256(abi.encodePacked(block.timestamp * block.number, msg.sender, block.timestamp + block.number))
        );
        // Check here that the amount does not exceed the
        if (flips > 64 || flips == 0) revert TooManyOrZeroFlips();
        assembly {
            let winningNumber := 2 // We will do a simple coin toss here with 2 outcomes [1] lose [2] win but any number can be used
            for { let i := flips } gt(i, 0) { i := sub(i, 1) } {
                // Shift the 'on' bit (F) to the correct position
                let shifted := shr(mul(i, 4), randomNumber)

                // check if winner using modulo to find a winning number.
                if eq(mod(shifted, winningNumber), 0) { numberWins := add(numberWins, 1) } // increment counter by 1
            }
        }
    }
}
