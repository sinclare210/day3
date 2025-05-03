// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {PollStation} from "../src/PollStation.sol";

contract PollStationScript is Script{
    PollStation public pollStation;

    function setUp() public {}
    
    function run () public{
        vm.startBroadcast();
        pollStation = new PollStation();
        vm.stopBroadcast();
    }
}