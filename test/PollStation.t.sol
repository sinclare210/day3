// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {PollStation} from "../src/PollStation.sol"; 


contract PollStationTest is Test {
    PollStation public pollStation;
    function setUp () public {
        pollStation = new PollStation();
    }

    function testAddCandidate () public {
        string[] memory Array = new string[](3);

        Array[0] = "Alice";
        Array[1] = "Bob";
        Array[2] = "Sinclair";

        pollStation.addCandidate(Array);

        string[] memory candidate = pollStation.getCandidate();

        assertEq(candidate[0], "Alice");
        assertEq(candidate[1], "Bob");
        assertEq(candidate[2], "Sinclair");
        assertEq(pollStation.getVote("Alice"), 0);
        assertEq(pollStation.getVote("Bob"), 0);
        assertEq(pollStation.getVote("Sinclair"), 0);

        
        
    }

    
}