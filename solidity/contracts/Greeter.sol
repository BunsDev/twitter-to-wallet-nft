// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.4 <0.9.0;

import "../deps/ERC721.sol";
import "openzeppelin-contracts/contracts/utils/cryptography/ECDSA.sol";

contract JailBreaker is ERC721 {

    using ECDSA for bytes32;

}
