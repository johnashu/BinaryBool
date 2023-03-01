// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/BinaryBool.sol";

contract BoolBinTest is Test {
    BoolBin public boolBin;
    address user = makeAddr("testUser");

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
    }

    function testAddColoursAssemblyStruct() public {
        boolBin.userDataOfUserBin(user);
        boolBin.addColoursAssemblyStructSingle(user, 0xf000000000000000000000000000000000000000000000000000000000f00000);
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
         boolBin.removeColoursAssemblyStruct(user);
        boolBin.userDataOfUserBin(user);
        boolBin.useBytesToCheckState(user);
        boolBin.useBytesToCheckStateAssembly(user);
        boolBin.userDataOfUserBin(user);
    }
}
