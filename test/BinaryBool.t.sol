// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/BinaryBool.sol";

contract BoolBinTest is Test {
    BoolBin public boolBin;
    address user = makeAddr("testUser");

    // Colours to use for high level checks
    bytes32 red =   0xf00000000000000000000000000000000000000000000000000000000000000f;
    bytes32 green = 0xf0000000000000000000000000000000000000000000000000000000000000f0;
    bytes32 blue =  0xf000000000000000000000000000000000000000000000000000000000000f00;
    bytes32 orange= 0xf00000000000000000000000000000000000000000000000000000000000f000;
    bytes32 black = 0xf0000000000000000000000000000000000000000000000000000000000f0000;
    bytes32 white = 0xf000000000000000000000000000000000000000000000000000000000f00000;
    bytes32 purple= 0xf00000000000000000000000000000000000000000000000000000000f000000;
    bytes32 pink =  0xf0000000000000000000000000000000000000000000000000000000f0000000;
    bytes32 gold =  0xf000000000000000000000000000000000000000000000000000000f00000000;
    bytes32 silver= 0xf00000000000000000000000000000000000000000000000000000f000000000;
    bytes32 peach = 0xf0000000000000000000000000000000000000000000000000000f0000000000;
    bytes32 bronze= 0xf000000000000000000000000000000000000000000000000000f00000000000;

    function setUp() public {
        boolBin = new BoolBin();
    }

    function testAddColoursAssemblyState() public {
        boolBin.userDataOfUserMap(user);
        boolBin.addColoursMapState(user);
        boolBin.userDataOfUserMap(user);
        boolBin.removeColoursMapState(user);
        boolBin.userDataOfUserMap(user);
        boolBin.addColoursMapState(user);
        boolBin.userDataOfUserMap(user);
        boolBin.removeColoursMapState(user);
        boolBin.userDataOfUserMap(user);
    }

    function testAddColoursMapAssembly() public {
        boolBin.userDataOfUserMap(user);
        boolBin.addColoursAssemblyMapping(user);
        boolBin.userDataOfUserMap(user);
        boolBin.removeColoursAssemblyMapping(user);
        boolBin.userDataOfUserMap(user);
        boolBin.addColoursAssemblyMapping(user);
        boolBin.userDataOfUserMap(user);
        boolBin.removeColoursAssemblyMapping(user);
        boolBin.userDataOfUserMap(user);
    }

    function testAddColoursStructBool() public {
        boolBin.userDataStruct(user);
        boolBin.addColoursStructBool(user, true);
        boolBin.userDataStruct(user);
        boolBin.addColoursStructBool(user, false);
        boolBin.userDataStruct(user);
        boolBin.addColoursStructBool(user, true);
        boolBin.userDataStruct(user);
        boolBin.addColoursStructBool(user, false);
        boolBin.userDataStruct(user);
        boolBin.addColoursStructBoolAddOne(user, true);
        boolBin.userDataStruct(user);
        boolBin.addColoursStructBoolAddOne(user, true);
        boolBin.userDataStruct(user);
        boolBin.useBoolsToCheckState(user);
        boolBin.addColoursStructBool(user, true);
        boolBin.userDataStruct(user);
         boolBin.useBoolsToCheckState(user);
    }

    function testAddColoursAssemblyStruct() public {
        boolBin.userDataOfUserBin(user);
        boolBin.addColoursAssemblyStructSingle(user, white);
        boolBin.userDataOfUserBin(user);
        boolBin.addColoursAssemblyStruct(user);
        boolBin.userDataOfUserBin(user);
        boolBin.removeColoursAssemblyStruct(user);
        boolBin.userDataOfUserBin(user);
        boolBin.addColoursAssemblyStruct(user);
        boolBin.userDataOfUserBin(user);
        boolBin.removeColoursAssemblyStruct(user);
        boolBin.userDataOfUserBin(user);
        boolBin.addColoursAssemblyStruct(user);
        boolBin.userDataOfUserBin(user);
        boolBin.useBytesToCheckState(user);
        boolBin.useBytesToCheckStateAssembly(user);
        boolBin.userDataOfUserBin(user);
        boolBin.removeColoursAssemblyStructSingle(user, green);
        boolBin.userDataOfUserBin(user);
        boolBin.useBytesToCheckState(user);
        boolBin.useBytesToCheckStateAssembly(user);
        boolBin.userDataOfUserBin(user);
        
    }
}
