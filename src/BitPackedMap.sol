// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract BitPackedMap {
    // Given a value for a square, return the corresponding fill rgb hex string
    // TODO: Make visibility internal
    function getFillFromSquare(uint256 square) public pure returns (string memory) {
        uint256 r;
        uint256 g;
        uint256 b;
        assembly {
            let firstBit := shr(0x03, square)
            r := mul(mod(shr(0x02, square), 2), 0xFF)
            g := mul(mod(shr(0x01, square), 2), 0xFF)
            b := mul(mod(square, 2), 0xFF)

            if eq(firstBit, 1) {
                r := div(r, 2)
                g := div(g, 2)
                b := div(b, 2)
            }
        }
        return string(abi.encodePacked("#", uintToHexString(r), uintToHexString(g), uintToHexString(b)));
    }

    // Returns bits corresponding to a square from the bitmap
    // TODO: Make visibility internal
    function getSquareFromMap(bytes32 bitmap, uint256 index) public pure returns (uint256 square) {
        assembly {
            let shift := mul(index, 4)
            square := shr(shift, and(shl(shift, shr(0xFC, not(0))), bitmap))
        }
    }

    // Returns svg string corresponding to a 32 byte bitmap
    // TODO: Make visibility internal
    function renderSvg(bytes32 bitmap) public view returns (string memory) {
        // string memory svgString = '<?xml version="1.0" encoding="UTF-8" standalone="no"?><svg xmlns="http://www.w3.org/2000/svg" version="1.1" viewBox="0 0 8 8">';

    }

    // Returns svg string corresponding to a specific tokenId
    function tokenSvg(uint256 tokenId) public view returns (string memory) {

    }

    // SOURCE: https://etherscan.io/address/0x8d04a8c79ceb0889bdd12acdf3fa9d207ed3ff63#code
    function uintToHexDigit(uint8 d) internal pure returns (bytes1) {
        if (0 <= d && d <= 9) {
            return bytes1(uint8(bytes1('0')) + d);
        } else if (10 <= uint8(d) && uint8(d) <= 15) {
            return bytes1(uint8(bytes1('a')) + d - 10);
        }
        revert();
    }

    // SOURCE: https://etherscan.io/address/0x8d04a8c79ceb0889bdd12acdf3fa9d207ed3ff63#code
    function uintToHexString(uint a) internal pure returns (string memory) {
        uint count = 0;
        uint b = a;
        while (b != 0) {
            count++;
            b /= 16;
        }
        bytes memory res = new bytes(count);
        for (uint i=0; i<count; ++i) {
            b = a % 16;
            res[count - i - 1] = uintToHexDigit(uint8(b));
            a /= 16;
        }
        
        string memory str = string(res);
        if (bytes(str).length == 0) {
            return "00";
        } else if (bytes(str).length == 1) {
            return string(abi.encodePacked("0", str));
        }
        return str;
    }
}
