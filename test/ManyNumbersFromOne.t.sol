// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/ManyRandomNumbersFromOne.sol";

contract TestManyRandomNumbersFromOne is Test {
    ManyRandomNumbersFromOne public manyRandomNumbersFromOne;
    address user = makeAddr("Doplays");

    function setUp() public {
        manyRandomNumbersFromOne = new ManyRandomNumbersFromOne();
    }

    function testmanyCoinPlays(uint256 x) public {
        vm.assume(x < 64 && x > 0);
        vm.roll(x + 1);
        uint256 flipped = manyRandomNumbersFromOne.manyCoinPlays(x);
        emit log_uint(flipped);
    }

    function testFailmanyCoinPlays(uint256 x) public {
        vm.assume(x > 64);
        manyRandomNumbersFromOne.manyCoinPlays(x);
    }
}
