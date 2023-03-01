// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.18;

contract BoolBin {
    mapping(address user => UserDataStruct userData) public userDataStruct;

    mapping(address user => UserDataBin userData) public userDataOfUserBin;

    mapping(address user => bytes32 userState) public userDataOfUserMap;

    // Keep the first byte as 'f', this means the hex will never go to zero and won't
    // need to be reinitialised. gas to reinit = 20k+
    // Could also use any of the left most as as an id of some sort..
    bytes32 allOff = 0xf000000000000000000000000000000000000000000000000000000000000000;
    bytes32 allOn = 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff;

    // Colours to use for high level checks
    bytes32 red = 0xf00000000000000000000000000000000000000000000000000000000000000f;
    bytes32 green = 0xf0000000000000000000000000000000000000000000000000000000000000f0;
    bytes32 blue = 0xf000000000000000000000000000000000000000000000000000000000000f00;
    bytes32 orange = 0xf00000000000000000000000000000000000000000000000000000000000f000;
    bytes32 black = 0xf0000000000000000000000000000000000000000000000000000000000f0000;
    bytes32 white = 0xf000000000000000000000000000000000000000000000000000000000f00000;
    bytes32 purple = 0xf00000000000000000000000000000000000000000000000000000000f000000;
    bytes32 pink = 0xf0000000000000000000000000000000000000000000000000000000f0000000;
    bytes32 gold = 0xf000000000000000000000000000000000000000000000000000000f00000000;
    bytes32 silver = 0xf00000000000000000000000000000000000000000000000000000f000000000;
    bytes32 peach = 0xf0000000000000000000000000000000000000000000000000000f0000000000;
    bytes32 bronze = 0xf000000000000000000000000000000000000000000000000000f00000000000;

    // Max 12 Bools allowed
    struct UserDataStruct {
        bool red;
        bool green;
        bool blue;
        bool orange;
        bool black;
        bool white;
        bool purple;
        bool pink;
        bool gold;
        bool silver;
        bool peach;
        bool bronze;
    }
    // uint64 lockUpTime;
    // bytes32 balance;
    // ...

    //
    struct UserDataBin {
        bytes32 state;
    }
    // bytes32 otherStates;
    // uint64 lockUpTime;
    // bytes32 balance;
    // ...

    // High Level
    function addColoursMapState(address user) public {
        userDataOfUserMap[user] = userDataOfUserMap[user] | red | green | blue | pink;
    }

    // High Level
    function removeColoursMapState(address user) public {
        userDataOfUserMap[user] = userDataOfUserMap[user] ^ red ^ green ^ blue ^ pink;
    }

    // Add to normal Mapping..
    function addColoursAssemblyMapping(address user) public {
        // Hash Key (user) and slot (2)
        bytes32 location = keccak256(abi.encode(user, 2));

        assembly {
            sstore(
                location,
                or(
                    sload(location),
                    or(
                        0xf00000000000000000000000000000000000000000000000000000000000000f,
                        or(
                            0xf0000000000000000000000000000000000000000000000000000000000000f0,
                            or(
                                0xf000000000000000000000000000000000000000000000000000000000000f00,
                                or(
                                    0xf00000000000000000000000000000000000000000000000000000000000f000,
                                    or(
                                        0xf0000000000000000000000000000000000000000000000000000000000f0000,
                                        or(
                                            0xf000000000000000000000000000000000000000000000000000000000f00000,
                                            or(
                                                0xf00000000000000000000000000000000000000000000000000000000f000000,
                                                or(
                                                    0xf0000000000000000000000000000000000000000000000000000000f0000000,
                                                    or(
                                                        0xf000000000000000000000000000000000000000000000000000000f00000000,
                                                        or(
                                                            0xf00000000000000000000000000000000000000000000000000000f000000000,
                                                            or(
                                                                0xf0000000000000000000000000000000000000000000000000000f0000000000,
                                                                0xf000000000000000000000000000000000000000000000000000f00000000000
                                                            )
                                                        )
                                                    )
                                                )
                                            )
                                        )
                                    )
                                )
                            )
                        )
                    )
                )
            )
        }
    }

    function removeColoursAssemblyMapping(address user) public {
        // Hash Key (user) and slot (2)
        bytes32 location = keccak256(abi.encode(user, 2));

        assembly {
            sstore(
                location,
                xor(
                    sload(location),
                    xor(
                        0xf00000000000000000000000000000000000000000000000000000000000000f,
                        xor(
                            0xf0000000000000000000000000000000000000000000000000000000000000f0,
                            xor(
                                0xf000000000000000000000000000000000000000000000000000000000000f00,
                                xor(
                                    0xf00000000000000000000000000000000000000000000000000000000000f000,
                                    xor(
                                        0xf0000000000000000000000000000000000000000000000000000000000f0000,
                                        xor(
                                            0xf000000000000000000000000000000000000000000000000000000000f00000,
                                            xor(
                                                0xf00000000000000000000000000000000000000000000000000000000f000000,
                                                xor(
                                                    0xf0000000000000000000000000000000000000000000000000000000f0000000,
                                                    xor(
                                                        0xf000000000000000000000000000000000000000000000000000000f00000000,
                                                        xor(
                                                            0xf00000000000000000000000000000000000000000000000000000f000000000,
                                                            xor(
                                                                0xf0000000000000000000000000000000000000000000000000000f0000000000,
                                                                0xf000000000000000000000000000000000000000000000000000f00000000000
                                                            )
                                                        )
                                                    )
                                                )
                                            )
                                        )
                                    )
                                )
                            )
                        )
                    )
                )
            )
        }
    }

    function addColoursAssemblyStructSingle(address user, bytes32 colour) public {
        UserDataBin storage userData = userDataOfUserBin[user];

        assembly {
            sstore(userData.slot, or(userData.offset, colour))
        }
    }

    function removeColoursAssemblyStructSingle(address user, bytes32 colour) public {
        UserDataBin storage userData = userDataOfUserBin[user];
        bytes32 _state = userDataOfUserBin[user].state;

        assembly {
            sstore(userData.slot, xor(_state, colour))
        }
    }

    function addColoursAssemblyStruct(address user) public {
        UserDataBin storage userData = userDataOfUserBin[user];
        assembly {
            sstore(
                userData.slot,
                or(
                    userData.offset,
                    or(
                        0xf00000000000000000000000000000000000000000000000000000000000000f,
                        or(
                            0xf0000000000000000000000000000000000000000000000000000000000000f0,
                            or(
                                0xf000000000000000000000000000000000000000000000000000000000000f00,
                                or(
                                    0xf00000000000000000000000000000000000000000000000000000000000f000,
                                    or(
                                        0xf0000000000000000000000000000000000000000000000000000000000f0000,
                                        or(
                                            0xf000000000000000000000000000000000000000000000000000000000f00000,
                                            or(
                                                0xf00000000000000000000000000000000000000000000000000000000f000000,
                                                or(
                                                    0xf0000000000000000000000000000000000000000000000000000000f0000000,
                                                    or(
                                                        0xf000000000000000000000000000000000000000000000000000000f00000000,
                                                        or(
                                                            0xf00000000000000000000000000000000000000000000000000000f000000000,
                                                            or(
                                                                0xf0000000000000000000000000000000000000000000000000000f0000000000,
                                                                0xf000000000000000000000000000000000000000000000000000f00000000000
                                                            )
                                                        )
                                                    )
                                                )
                                            )
                                        )
                                    )
                                )
                            )
                        )
                    )
                )
            )
        }
    }

    function removeColoursAssemblyStruct(address user) public {
        UserDataBin storage userData = userDataOfUserBin[user];
        bytes32 _state = userDataOfUserBin[user].state;

        assembly {
            sstore(
                userData.slot,
                xor(
                    _state,
                    xor(
                        0xf00000000000000000000000000000000000000000000000000000000000000f,
                        xor(
                            0xf0000000000000000000000000000000000000000000000000000000000000f0,
                            xor(
                                0xf000000000000000000000000000000000000000000000000000000000000f00,
                                xor(
                                    0xf00000000000000000000000000000000000000000000000000000000000f000,
                                    xor(
                                        0xf0000000000000000000000000000000000000000000000000000000000f0000,
                                        xor(
                                            0xf000000000000000000000000000000000000000000000000000000000f00000,
                                            xor(
                                                0xf00000000000000000000000000000000000000000000000000000000f000000,
                                                xor(
                                                    0xf0000000000000000000000000000000000000000000000000000000f0000000,
                                                    xor(
                                                        0xf000000000000000000000000000000000000000000000000000000f00000000,
                                                        xor(
                                                            0xf00000000000000000000000000000000000000000000000000000f000000000,
                                                            xor(
                                                                0xf0000000000000000000000000000000000000000000000000000f0000000000,
                                                                0xf000000000000000000000000000000000000000000000000000f00000000000
                                                            )
                                                        )
                                                    )
                                                )
                                            )
                                        )
                                    )
                                )
                            )
                        )
                    )
                )
            )
        }
    }

    function addColoursStructBool(address user, bool state) public {
        UserDataStruct storage userData = userDataStruct[user];
        userData.red = state;
        userData.blue = state;
        userData.green = state;
        userData.orange = state;
        userData.black = state;
        userData.white = state;
        userData.purple = state;
        userData.pink = state;
        userData.gold = state;
        userData.silver = state;
        userData.bronze = state;
        userData.peach = state;
    }

    function addColoursStructBoolAddOne(address user, bool state) public {
        UserDataStruct storage userData = userDataStruct[user];
        userData.red = state;
    }

    function useBoolsToCheckState(address user) public returns (bool) {
        // Gas 2193 true / 943 false
        UserDataStruct storage userData = userDataStruct[user];
        return  userData.red &&
                userData.blue &&
                userData.green &&
                userData.orange &&
                userData.black &&
                userData.white &&
                userData.purple &&
                userData.pink &&
                userData.gold &&
                userData.silver &&
                userData.bronze &&
                userData.peach;
    }

    function useBytesToCheckState(address user) public returns (bool) {
        // Gas 6927 true / 927 false
        // 0xf000000000000000000000000000000000000000000000000000000000000fff
        bytes32 expected = red ^ green ^ blue;
        return expected & userDataOfUserBin[user].state == expected;
    }

    function useBytesToCheckStateAssembly(address user) public returns (bool matched) {
        // Gas 666 everytime
        bytes32 _state = userDataOfUserBin[user].state;

        assembly {
            let expected :=
                xor(
                    _state,
                    xor(
                        0xf00000000000000000000000000000000000000000000000000000000000000f,
                        xor(
                            0xf0000000000000000000000000000000000000000000000000000000000000f0,
                            xor(
                                0xf000000000000000000000000000000000000000000000000000000000000f00,
                                xor(
                                    0xf00000000000000000000000000000000000000000000000000000000000f000,
                                    xor(
                                        0xf0000000000000000000000000000000000000000000000000000000000f0000,
                                        xor(
                                            0xf000000000000000000000000000000000000000000000000000000000f00000,
                                            xor(
                                                0xf00000000000000000000000000000000000000000000000000000000f000000,
                                                xor(
                                                    0xf000000000000000000000000000000000000000000000000000000f00000000,
                                                    xor(
                                                        0xf00000000000000000000000000000000000000000000000000000f000000000,
                                                        xor(
                                                            0xf0000000000000000000000000000000000000000000000000000f0000000000,
                                                            0xf000000000000000000000000000000000000000000000000000f00000000000
                                                        )
                                                    )
                                                )
                                            )
                                        )
                                    )
                                )
                            )
                        )
                    )
                )

            matched := eq(and(expected, _state), expected)
        }
    }
}
