// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {PollStation} from "../src/PollStation.sol"; 


contract PollStationTest is Test {
    PollStation public pollStation;
    function setUp () public {
        pollStation = new PollStation();
    }

    
}