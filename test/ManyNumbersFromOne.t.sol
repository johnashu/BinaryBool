// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/ManyNumbersFromOne.sol";

contract TestManyNumbersFromOne is Test {
    ManyNumbersFromOne public manyNumbersFromOne;
    address user = makeAddr("DoFlips");

    function setUp() public {
        manyNumbersFromOne = new ManyNumbersFromOne();
    }

    function testManyCoinFlips(uint256 x) public {
        vm.assume(x < 64 && x > 0);
        vm.roll(x + 1);
        uint256 flipped = manyNumbersFromOne.manyCoinFlips(x);
        emit log_uint(flipped);
    }

    function testFailManyCoinFlips(uint256 x) public {
        vm.assume(x > 64);
        manyNumbersFromOne.manyCoinFlips(x);
    }
}
