// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

/// @title BitPackedMap
/// @author https://github.com/kadenzipfel
/// @notice Bitpacked 8x8 bitmap
contract BitPackedMap {
    mapping(uint256 => bytes32) bitmaps;

    /// @notice Given a value for a square, return the corresponding fill rgb hex string.
    /// @param  square 4 bit uint denoting the color of the square.
    /// @return fill rgb hex string corresponding to square.
    function _getFillFromSquare(uint256 square) internal pure returns (string memory) {
        string[16] memory colors = [
            "#ffffff",
            "#aaaaaa",
            "#555555",
            "#000000",
            "#ffff55",
            "#00aa00",
            "#55ff55",
            "#ff5555",
            "#aa0000",
            "#aa5500",
            "#aa00aa",
            "#ff55ff",
            "#55ffff",
            "#00aaaa",
            "#0000aa",
            "#5555ff"
        ];

        return colors[square];
    }

    /// @notice Given a bitmap and index, returns bits corresponding to the square at index.
    /// @param  bitmap 32 byte value containing all bitmap data.
    /// @param  index index of square being retrieved.
    /// @return square 4 bit uint denoting the color of the square.
    function _getSquareFromMap(bytes32 bitmap, uint256 index) internal pure returns (uint256 square) {
        assembly {
            let shift := sub(252, mul(index, 4))
            square := shr(shift, and(shl(shift, shr(0xFC, not(0))), bitmap))
        }
    }

    /// @notice Given a bitmap, returns corresponding svg string.
    /// @param  bitmap 32 byte value containing all bitmap data.
    /// @return svg string to display bitmap.
    function _renderSvg(bytes32 bitmap) public pure returns (string memory) {
        string memory svgString = '<?xml version="1.0" encoding="UTF-8" standalone="no"?><svg xmlns="http://www.w3.org/2000/svg" version="1.1" viewBox="0 0 8 8">';

        string[8] memory pixelRow;

        uint256 y = 0;
        for (uint i; i < 64; i += 8) {
            pixelRow[0] = string(abi.encodePacked('<rect fill="', _getFillFromSquare(_getSquareFromMap(bitmap, i)), '" x="0" y="', _toString(y), '" width="1" height="1" />'));
            pixelRow[1] = string(abi.encodePacked('<rect fill="', _getFillFromSquare(_getSquareFromMap(bitmap, i + 1)), '" x="1" y="', _toString(y), '" width="1" height="1" />'));
            pixelRow[2] = string(abi.encodePacked('<rect fill="', _getFillFromSquare(_getSquareFromMap(bitmap, i + 2)), '" x="2" y="', _toString(y), '" width="1" height="1" />'));
            pixelRow[3] = string(abi.encodePacked('<rect fill="', _getFillFromSquare(_getSquareFromMap(bitmap, i + 3)), '" x="3" y="', _toString(y), '" width="1" height="1" />'));
            pixelRow[4] = string(abi.encodePacked('<rect fill="', _getFillFromSquare(_getSquareFromMap(bitmap, i + 4)), '" x="4" y="', _toString(y), '" width="1" height="1" />'));
            pixelRow[5] = string(abi.encodePacked('<rect fill="', _getFillFromSquare(_getSquareFromMap(bitmap, i + 5)), '" x="5" y="', _toString(y), '" width="1" height="1" />'));
            pixelRow[6] = string(abi.encodePacked('<rect fill="', _getFillFromSquare(_getSquareFromMap(bitmap, i + 6)), '" x="6" y="', _toString(y), '" width="1" height="1" />'));
            pixelRow[7] = string(abi.encodePacked('<rect fill="', _getFillFromSquare(_getSquareFromMap(bitmap, i + 7)), '" x="7" y="', _toString(y), '" width="1" height="1" />'));
            
            svgString = string(abi.encodePacked(svgString, pixelRow[0], pixelRow[1], pixelRow[2], pixelRow[3], pixelRow[4], pixelRow[5], pixelRow[6], pixelRow[7]));

            unchecked {
                ++y;
            }
        }

        svgString = string(abi.encodePacked(svgString, "</svg>"));
        return svgString;
    }

    /// @notice Add a bitmap to a corresponding tokenId.
    /// @param  tokenId ID of token to add a bitmap to.
    /// @param  bitmap 32 byte value containing all bitmap data.
    function _addBitmap(uint256 tokenId, bytes32 bitmap) internal virtual {
        bitmaps[tokenId] = bitmap;
    }

    /// @notice Given a tokenId, returns corresponding bitmap svg string.
    /// @param  tokenId ID of token to retrieve bitmap svg string.
    /// @return svg string to display bitmap.
    function tokenSvg(uint256 tokenId) public view returns (string memory) {
        return _renderSvg(bitmaps[tokenId]);
    }

    // SOURCE: https://etherscan.io/address/0x8d04a8c79ceb0889bdd12acdf3fa9d207ed3ff63#code
    function _uintToHexDigit(uint8 d) private pure returns (bytes1) {
        if (0 <= d && d <= 9) {
            return bytes1(uint8(bytes1('0')) + d);
        } else if (10 <= uint8(d) && uint8(d) <= 15) {
            return bytes1(uint8(bytes1('a')) + d - 10);
        }
        revert();
    }

    // SOURCE: https://etherscan.io/address/0x8d04a8c79ceb0889bdd12acdf3fa9d207ed3ff63#code
    function _uintToHexString(uint a) private pure returns (string memory) {
        uint count = 0;
        uint b = a;
        while (b != 0) {
            count++;
            b /= 16;
        }
        bytes memory res = new bytes(count);
        for (uint i=0; i<count; ++i) {
            b = a % 16;
            res[count - i - 1] = _uintToHexDigit(uint8(b));
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

    // SOURCE: https://github.com/OpenZeppelin/openzeppelin-contracts/blob/3210a8653b66726114226ee5153bbcf59b0475bd/contracts/utils/Strings.sol#L16
    function _toString(uint256 value) private pure returns (string memory) {
        // Inspired by OraclizeAPI's implementation - MIT licence
        // https://github.com/oraclize/ethereum-api/blob/b42146b063c7d6ee1358846c198246239e9360e8/oraclizeAPI_0.4.25.sol

        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }
}
