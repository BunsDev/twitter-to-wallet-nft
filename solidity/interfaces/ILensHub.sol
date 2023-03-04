// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4 <0.9.0;

interface ILensHub {
  //@param tokenId lens profile id
  //@returns a
  function ownerOf(uint256 tokenId) external view returns (address);

  function defaultProfile(address wallet) external view returns (uint256);
}
