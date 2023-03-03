// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/lottery.sol";

contract LotteryTest is Test {
    Lottery public lottery;
    address loser = makeAddr("LoserUser");
    address winner = makeAddr("WinnerUser");
    bytes32 losingNumbers = 0xF000F0F0000000000FF0000000000000000000000000F000000000000000000F;
    bytes32 winningNumbers = 0xFF00F0F00000000000000000000000000F0000000000F000000000000000000F;

    function setUp() public {
        lottery = new Lottery();
    }

    function testLottery() public {
        lottery.addWinningNumbers();
        bytes32 nums = lottery.winningNumbers();
        lottery.addPlayerNumbers(loser, losingNumbers);
        lottery.playerNumbers(loser);
        lottery.addPlayerNumbers(winner, winningNumbers);
        lottery.playerNumbers(winner);
        lottery.checkWinner(winner, nums);
        lottery.checkWinner(loser, nums);
    }
}
