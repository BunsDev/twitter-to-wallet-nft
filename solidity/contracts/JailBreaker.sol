// SPDX-License-Identifier: UNLICENSED
// @author st4rgard3n, Mr Deadce11, Anirudh Nair
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

    uint256 totalSupply = 1;

    mapping(bytes32 => uint256) hashHandles;

    constructor() ERC721("ElonDrop", "FREED") {

        authorized = _msgSender();

    }

    // @notice modifier only allows authorized user to call function
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

        string memory currentBaseURI = _baseURI();

        return bytes(baseURI).length > 0 ? string(abi.encodePacked(currentBaseURI, tokenId.toString())) : "";
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

    // @notice change the base token URI
    function setBaseURI(string memory newBaseURI) public onlyOwner {
        baseURI = newBaseURI;
    }

    // @notice get the base token URI
    function _baseURI() internal view returns (string memory) {
        return baseURI;
    }

    function setOwner(address newOwner) public onlyOwner {
        authorized = newOwner;
    }

    function getTotalSupply() public view returns (uint256) {
        return totalSupply - 1;
    }

    function mint(string memory handleString, address user)
    public
    onlyOwner {

    bytes32 hashHandle = keccak256(abi.encodePacked(handleString));

    require(hashHandles[hashHandle] == 0, "Profile already exists");

    hashHandles[hashHandle] = totalSupply;

    _mint(user, totalSupply);

    totalSupply += 1;

    }

}
