// SPDX-License-Identifier: SEE LICENSE IN LICENSE

// Maffaz 2023

pragma solidity 0.8.18;

contract AddRemoveFlags {
    // Slot 0
    mapping(address player => bytes32 flags) public userFlags;

    // The F at 0 position is there to stop the state from resetting to zero.
    // If this happens, it will cost 21k+Gas to reinit to a positive integer.
    // numbers start from 1 and go to 63..
    /*
                     0123456789...                                               ...63*/
    bytes32 base = 0xF000000000000000000000000000000000000000000000000000000000000000; // slot 1

    /// @dev Adds a flag 'F' to postion a in the bytes32 word of a users state
    /// @param user address of the user to update their state.
    /// @param pos position in the bytes32 word to place the flag.
    /// @return state users updated state as a bytes32 word
    function addFlagToPosition(address user, uint256 pos) public returns (bytes32 state) {
        // Hash Key (user) and slot (0)
        bytes32 location = keccak256(abi.encode(user, 0x0));

        assembly {
            let _base := sload(base.slot)

            // get the users current state
            state := or(_base, sload(location))

            // First we need to make sure that the position does not exist already.
            // If it is on, it will turn off as we are simply flipping a switch.
            // Use AND to see if we have a flag already and if so, return the state as it came in.

            // Shift the 'on' bit (F) to the correct position
            let shifted := shr(mul(pos, 4), sload(base.slot))

            // AND to create a new state
            let anded := and(state, shifted)

            // check if equal.

            // Check if they are equal, if so, it will return the state. else carry on and add the flag..
            if not(eq(anded, shifted)) {
                state := xor(state, shifted)
                sstore(location, state)
            }
        }
    }

    /// @dev removes a flag 'F' from a postion in the bytes32 word of a users state
    /// @param user address of the user to update their state.
    /// @param pos position in the bytes32 word to place the flag.
    /// @return state users updated state as a bytes32 word
    function removeFlagFromPosition(address user, uint8 pos) public returns (bytes32 state) {
        // Hash Key (user) and slot (0)
        bytes32 location = keccak256(abi.encode(user, 0x0));
        assembly {
            let _base := sload(base.slot)

            // get the users current state
            state := or(_base, sload(location))

            // First we need to make sure that the position does not exist already.
            // If it is on, it will turn off as we are simply flipping a switch.
            // Use AND to see if we have a flag already and if so, return the state as it came in.

            // Shift the 'on' bit (F) to the correct position
            let shifted := shr(mul(pos, 4), sload(base.slot))

            // AND to create a new state
            let anded := and(state, shifted)

            // Check if they are equal, if so, it will return the state. else carry on and add the flag..
            if eq(anded, shifted) {
                state := xor(state, shifted)
                sstore(location, state)
            }
        }
    }
}
