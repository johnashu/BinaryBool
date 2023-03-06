// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/ManyNumbersFromOne.sol";

contract TestManyNumbersFromOne is Test {
    ManyNumbersFromOne public manyNumbersFromOne;
    address user = makeAddr("Doplays");

    function setUp() public {
        manyNumbersFromOne = new ManyNumbersFromOne();
    }

    function testmanyCoinPlays(uint256 x) public {
        vm.assume(x < 64 && x > 0);
        vm.roll(x + 1);
        uint256 flipped = manyNumbersFromOne.manyCoinPlays(x);
        emit log_uint(flipped);
    }

    function testFailmanyCoinPlays(uint256 x) public {
        vm.assume(x > 64);
        manyNumbersFromOne.manyCoinPlays(x);
    }
}
