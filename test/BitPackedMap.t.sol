// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/BitPackedMap.sol";

contract BitPackedMapTest is Test {
    BitPackedMap bpm;

    function setUp() public {
        bpm = new BitPackedMap();
    }

    function testGetSquareFromMap() public {
        uint256 square = bpm.getSquareFromMap(0x7624778dedc75f8b322b9fa1632a610d40b85e106c7d9bf0e743a9ce291b9c63, 39);
        assertEq(square, 0x06);
    }

    function testGetFillFromSquare() public {
        string memory fill = bpm.getFillFromSquare(13);
        assertEq(fill, "#7f007f");
    }
}
