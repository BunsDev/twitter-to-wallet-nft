// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.4 <0.9.0;

import 'forge-std/Test.sol';
import '../../contracts/JailBreaker.sol';
import '../../interfaces/ILensHub.sol';
import '../../../lib/openzeppelin-contracts/contracts/utils/cryptography/ECDSA.sol';
import '../../../lib/openzeppelin-contracts/contracts/utils/cryptography/SignatureChecker.sol';

contract JailBreakerTest is Test {
  JailBreaker public jailbreaker;
  address public owner;
  address public user;
  address public lenshub = 0x7582177F9E536aB0b6c721e11f383C326F2Ad1D5;
  ILensHub public ilenshub;

  uint256 public ownerPrivateKey = 0x05e8c41d4470d512ed2fe0352400318b0e819550af8773e613f560d46c640b8c;
  uint256 public userPrivateKey = 0x05e8c41d4470d512ed2fe0352400318b0e819550af8773e613f560d46c640b90;

  event TokenMinted(uint256 tokenId, bytes32 hashandle);

  function setUp() public {
    jailbreaker = new JailBreaker();
    owner = vm.addr(ownerPrivateKey);
    user = vm.addr(userPrivateKey);
    jailbreaker.setLensHubAddress(lenshub);
  }

  function testMint() public {
    vm.expectEmit(true, true, false, false, address(jailbreaker));
    emit TokenMinted(uint256(1), keccak256('@testHandle'));
    jailbreaker.mint('@testHandle', user);
  }

  function testLockProfile() public {
    jailbreaker.mint('@testHandle', user);
    vm.mockCall(address(lenshub), abi.encodeWithSelector(ilenshub.ownerOf.selector), abi.encode(address(user)));
    assertEq(jailbreaker.profileOwnerOf(1), address(user));
    //create signedEthMessage with lens profile id and owner of profile
    bytes32 hash = keccak256(abi.encode(keccak256('unit256 tokenId'), 1));
    (uint8 v, bytes32 r, bytes32 s) = vm.sign(userPrivateKey, hash);
    console.logUint(v);
    console.logBytes32(r);
    console.logBytes32(s);
    bytes memory signature = bytes.concat(abi.encodePacked(v), r, s);
    console.logBytes(signature);
    vm.prank(user);
    jailbreaker.lockProfile(1, 1, signature);
  }

  function testOwnerOf() public {
    jailbreaker.mint('@testHandle', user);
    assertEq(jailbreaker.ownerOf(1), user);
  }
}
