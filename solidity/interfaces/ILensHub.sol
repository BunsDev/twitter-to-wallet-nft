// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4 <0.9.0;

interface ILensHub {
  //@param tokenId lens profile id
  //@returns address of lens profile id owner
  function ownerOf(uint256 tokenId) external view returns (address);
  //@param wallet wallet address
  //@returns lens profile id connected with wallet address
  function defaultProfile(address wallet) external view returns (uint256);
}
