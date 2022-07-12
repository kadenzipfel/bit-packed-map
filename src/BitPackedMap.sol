// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract BitPackedMap {
    // Given a value for a square, return the corresponding fill rgb hex string
    function getFillFromBits(uint256) internal view returns (string memory) {

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
}
