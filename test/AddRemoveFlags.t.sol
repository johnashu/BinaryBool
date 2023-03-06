// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/AddRemoveFlags.sol";

contract TestAddRemoveFlags is Test {
    AddRemoveFlags public addRemoveFlags;
    address user = makeAddr("AddFlags");

    bytes32 addedCheck = 0xFF00000000000000000000000000000000000000000000000000000000000000;
    bytes32 removedCheck = 0xF000000000000000000000000000000000000000000000000000000000000000;

    function setUp() public {
        addRemoveFlags = new AddRemoveFlags();
    }

    function testAddFlag() public {
        bytes32 added = addRemoveFlags.addFlagToPosition(user, 1);
        assertEq(added, addedCheck);

        addRemoveFlags.userFlags(user);

        bytes32 removed = addRemoveFlags.removeFlagFromPosition(user, 1);
        assertEq(removed, removedCheck);
        
    }


}
