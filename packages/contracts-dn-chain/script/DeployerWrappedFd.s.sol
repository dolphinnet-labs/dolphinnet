// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Vm.sol";
import {console, Script} from "forge-std/Script.sol";

import {WDN} from "../src/core/token/WFD.sol";

contract DeployerWrappedFdScript is Script {
    WDN public wFD;

    function run() public {
        vm.startBroadcast();
        wFD = new WDN();
        console.log("deploy wFD:", address(wFD));
        console.log("wFD", wFD.name());
        vm.stopBroadcast();
    }
}
