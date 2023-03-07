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

    function testSingleManyRandomPlays(uint256 x) public {
        uint256 playswon = manyRandomNumbersFromOne.manyRandomPlays(1);
        emit log_uint(playswon);
    }

    function testSingleManyRandomPlaysNormal(uint256 x) public {
        uint256 playswon = manyRandomNumbersFromOne.manyRandomPlaysNormal(1);
        emit log_uint(playswon);
    }

    function testManyRandomPlaysFuzzed(uint256 x) public {
        vm.assume(x > 1 && x < 64);
        vm.roll(x % 10 * 10_000_000);

        uint256 playswon = manyRandomNumbersFromOne.manyRandomPlays(x);
        emit log_uint(playswon);
    }

    function testManyRandomPlaysNormalFuzzed(uint256 x) public {
        vm.assume(x > 1 && x < 64);
        vm.roll(x % 10 * 10_000_000);
        uint256 playswon = manyRandomNumbersFromOne.manyRandomPlaysNormal(x);
        emit log_uint(playswon);
    }

    function testManyRandomPlaysMax(uint256 x) public {
        vm.assume(x < 10_000_000);
        vm.roll(x);
        uint256 playswon = manyRandomNumbersFromOne.manyRandomPlays(64);
        emit log_uint(playswon);
    }

    function testManyRandomPlaysNormalMax(uint256 x) public {
        vm.assume(x < 10_000_000);
        vm.roll(x);
        uint256 playswon = manyRandomNumbersFromOne.manyRandomPlaysNormal(64);
        emit log_uint(playswon);
    }

    function testFailManyRandomPlays(uint256 x) public {
        vm.assume(x > 64);
        manyRandomNumbersFromOne.manyRandomPlays(x);
    }

    function testFailManyRandomPlaysNormal(uint256 x) public {
        vm.assume(x > 64);
        manyRandomNumbersFromOne.manyRandomPlaysNormal(x);
    }
}
