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

    function testRenderSvg() public {
        string memory svg = bpm.renderSvg(0x7624778dedc75f8b322b9fa1632a610d40b85e106c7d9bf0e743a9ce291b9c63);
        assertEq(svg, "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?><svg xmlns=\"http://www.w3.org/2000/svg\" version=\"1.1\" viewBox=\"0 0 8 8\"><rect fill=\"#00ffff\" x=\"0\" y=\"0\" width=\"1\" height=\"1\" /><rect fill=\"#ffff00\" x=\"1\" y=\"0\" width=\"1\" height=\"1\" /><rect fill=\"#7f0000\" x=\"2\" y=\"0\" width=\"1\" height=\"1\" /><rect fill=\"#00007f\" x=\"3\" y=\"0\" width=\"1\" height=\"1\" /><rect fill=\"#007f7f\" x=\"4\" y=\"0\" width=\"1\" height=\"1\" /><rect fill=\"#0000ff\" x=\"5\" y=\"0\" width=\"1\" height=\"1\" /><rect fill=\"#00007f\" x=\"6\" y=\"0\" width=\"1\" height=\"1\" /><rect fill=\"#00ff00\" x=\"7\" y=\"0\" width=\"1\" height=\"1\" /><rect fill=\"#7f7f00\" x=\"0\" y=\"1\" width=\"1\" height=\"1\" /><rect fill=\"#7f0000\" x=\"1\" y=\"1\" width=\"1\" height=\"1\" /><rect fill=\"#00007f\" x=\"2\" y=\"1\" width=\"1\" height=\"1\" /><rect fill=\"#007f00\" x=\"3\" y=\"1\" width=\"1\" height=\"1\" /><rect fill=\"#00ffff\" x=\"4\" y=\"1\" width=\"1\" height=\"1\" /><rect fill=\"#ff0000\" x=\"5\" y=\"1\" width=\"1\" height=\"1\" /><rect fill=\"#ffffff\" x=\"6\" y=\"1\" width=\"1\" height=\"1\" /><rect fill=\"#7f7f00\" x=\"7\" y=\"1\" width=\"1\" height=\"1\" /><rect fill=\"#000000\" x=\"0\" y=\"2\" width=\"1\" height=\"1\" /><rect fill=\"#7f7f7f\" x=\"1\" y=\"2\" width=\"1\" height=\"1\" /><rect fill=\"#007f7f\" x=\"2\" y=\"2\" width=\"1\" height=\"1\" /><rect fill=\"#00007f\" x=\"3\" y=\"2\" width=\"1\" height=\"1\" /><rect fill=\"#7f007f\" x=\"4\" y=\"2\" width=\"1\" height=\"1\" /><rect fill=\"#ffffff\" x=\"5\" y=\"2\" width=\"1\" height=\"1\" /><rect fill=\"#7f0000\" x=\"6\" y=\"2\" width=\"1\" height=\"1\" /><rect fill=\"#ffff00\" x=\"7\" y=\"2\" width=\"1\" height=\"1\" /><rect fill=\"#000000\" x=\"0\" y=\"3\" width=\"1\" height=\"1\" /><rect fill=\"#0000ff\" x=\"1\" y=\"3\" width=\"1\" height=\"1\" /><rect fill=\"#7f7f00\" x=\"2\" y=\"3\" width=\"1\" height=\"1\" /><rect fill=\"#ff00ff\" x=\"3\" y=\"3\" width=\"1\" height=\"1\" /><rect fill=\"#000000\" x=\"4\" y=\"3\" width=\"1\" height=\"1\" /><rect fill=\"#007f7f\" x=\"5\" y=\"3\" width=\"1\" height=\"1\" /><rect fill=\"#000000\" x=\"6\" y=\"3\" width=\"1\" height=\"1\" /><rect fill=\"#ff0000\" x=\"7\" y=\"3\" width=\"1\" height=\"1\" /><rect fill=\"#7f007f\" x=\"0\" y=\"4\" width=\"1\" height=\"1\" /><rect fill=\"#000000\" x=\"1\" y=\"4\" width=\"1\" height=\"1\" /><rect fill=\"#0000ff\" x=\"2\" y=\"4\" width=\"1\" height=\"1\" /><rect fill=\"#ffff00\" x=\"3\" y=\"4\" width=\"1\" height=\"1\" /><rect fill=\"#007f00\" x=\"4\" y=\"4\" width=\"1\" height=\"1\" /><rect fill=\"#00ff00\" x=\"5\" y=\"4\" width=\"1\" height=\"1\" /><rect fill=\"#00ffff\" x=\"6\" y=\"4\" width=\"1\" height=\"1\" /><rect fill=\"#ffff00\" x=\"7\" y=\"4\" width=\"1\" height=\"1\" /><rect fill=\"#0000ff\" x=\"0\" y=\"5\" width=\"1\" height=\"1\" /><rect fill=\"#007f00\" x=\"1\" y=\"5\" width=\"1\" height=\"1\" /><rect fill=\"#7f7f7f\" x=\"2\" y=\"5\" width=\"1\" height=\"1\" /><rect fill=\"#00007f\" x=\"3\" y=\"5\" width=\"1\" height=\"1\" /><rect fill=\"#007f7f\" x=\"4\" y=\"5\" width=\"1\" height=\"1\" /><rect fill=\"#00ff00\" x=\"5\" y=\"5\" width=\"1\" height=\"1\" /><rect fill=\"#00ff00\" x=\"6\" y=\"5\" width=\"1\" height=\"1\" /><rect fill=\"#00ffff\" x=\"7\" y=\"5\" width=\"1\" height=\"1\" /><rect fill=\"#007f7f\" x=\"0\" y=\"6\" width=\"1\" height=\"1\" /><rect fill=\"#000000\" x=\"1\" y=\"6\" width=\"1\" height=\"1\" /><rect fill=\"#7f7f7f\" x=\"2\" y=\"6\" width=\"1\" height=\"1\" /><rect fill=\"#ff00ff\" x=\"3\" y=\"6\" width=\"1\" height=\"1\" /><rect fill=\"#ffffff\" x=\"4\" y=\"6\" width=\"1\" height=\"1\" /><rect fill=\"#7f0000\" x=\"5\" y=\"6\" width=\"1\" height=\"1\" /><rect fill=\"#7f007f\" x=\"6\" y=\"6\" width=\"1\" height=\"1\" /><rect fill=\"#7f7f00\" x=\"7\" y=\"6\" width=\"1\" height=\"1\" /><rect fill=\"#7f007f\" x=\"0\" y=\"7\" width=\"1\" height=\"1\" /><rect fill=\"#000000\" x=\"1\" y=\"7\" width=\"1\" height=\"1\" /><rect fill=\"#ffffff\" x=\"2\" y=\"7\" width=\"1\" height=\"1\" /><rect fill=\"#ffffff\" x=\"3\" y=\"7\" width=\"1\" height=\"1\" /><rect fill=\"#ff0000\" x=\"4\" y=\"7\" width=\"1\" height=\"1\" /><rect fill=\"#00ff00\" x=\"5\" y=\"7\" width=\"1\" height=\"1\" /><rect fill=\"#ffff00\" x=\"6\" y=\"7\" width=\"1\" height=\"1\" /><rect fill=\"#ffffff\" x=\"7\" y=\"7\" width=\"1\" height=\"1\" /></svg>");
    }
}