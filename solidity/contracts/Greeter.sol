// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.4 <0.9.0;

import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "../deps/ERC721.sol";


contract JailBreaker is ERC721 {

    using ECDSA for bytes32;

}
