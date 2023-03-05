// SPDX-License-Identifier: UNLICENSED
// @author st4rgard3n, Mr Deadce11, Anirudh Nair
pragma solidity >=0.8.4 <0.9.0;

import 'forge-std/Script.sol';
import {JailBreaker} from '../contracts/JailBreaker.sol';

// forge scripts scripts/Jailbreaker.s.sol:DeployJailBreaker --rpc-url $RU --private-key $PK --broadcast --verify --etherscan-api-key $EK -vvvv

contract DeployJailBreaker is Script {
  function run() external {
    vm.startBroadcast();

    new JailBreaker();

    vm.stopBroadcast();
  }
}
