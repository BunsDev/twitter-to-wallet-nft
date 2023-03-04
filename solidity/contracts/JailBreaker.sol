// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.4 <0.9.0;

import "solmate/tokens/ERC721.sol";
import "../../lib/openzeppelin-contracts/contracts/utils/cryptography/ECDSA.sol";
import "../../lib/openzeppelin-contracts/contracts/utils/Context.sol";
import "../../lib/openzeppelin-contracts/contracts/utils/Strings.sol";

contract JailBreaker is ERC721, Context {

    using ECDSA for bytes32;
    using Strings for uint256;

    string baseURI;

    address authorized;

    constructor() ERC721("", "") {

    }

    modifier onlyOwner {
        require(_msgSender() == authorized, "Only owner!");
        _;
    }

    // @notice returns the token URI of a given token
    // @params the token's id
    function tokenURI(uint256 tokenId)
    override
    public
    view
    returns (string memory) {

        require(_exists(tokenId), "Token must exist!");

        string memory baseURI = _baseURI();

        return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, tokenId.toString())) : "";
    }

    /**
     * @dev Returns whether `tokenId` exists.
     *
     * Tokens can be managed by their owner or approved accounts via {approve} or {setApprovalForAll}.
     *
     * Tokens start existing when they are minted (`_mint`),
     * and stop existing when they are burned (`_burn`).
     */
    function _exists(uint256 tokenId) internal view virtual returns (bool) {
        return ownerOf(tokenId) != address(0);
    }

    function setBaseURI(string memory newBaseURI) onlyOwner {
        baseURI = newBaseURI;
    }

    function _baseURI() returns (string memory) {
        return baseURI;
    }

}
