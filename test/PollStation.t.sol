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

    function testAddCandidateRevert () public {
        string[] memory Array = new string[](3);

        Array[0] = "Alice";
        Array[1] = "Bob";
        Array[2] = "";

        vm.expectRevert();
        pollStation.addCandidate(Array);
    }

    function testAddCandidateRevertIfVoted () public {
        string[] memory Array = new string[](3);

        Array[0] = "Alice";
        Array[1] = "Bob";
        Array[2] = "Sinclair";

        pollStation.addCandidate(Array);

        string[] memory candidate  = pollStation.getCandidate();

        assertEq(candidate[0], "Alice");
        assertEq(candidate[1], "Bob");
        assertEq(candidate[2], "Sinclair");
        assertEq(pollStation.getVote("Alice"), 0);
        assertEq(pollStation.getVote("Bob"), 0);
        

        pollStation.vote("Sinclair");
        //revert if candidate already has a vote
        vm.expectRevert();
        pollStation.addCandidate(Array);
    }

    function testVote() public {
        string[] memory Array = new string[](3);

        Array[0] = "Alice";
        Array[1] = "Bob";
        Array[2] = "Sinclair";

        pollStation.addCandidate(Array);

        string[] memory candidate  = pollStation.getCandidate();

        assertEq(candidate[0], "Alice");
        assertEq(candidate[1], "Bob");
        assertEq(candidate[2], "Sinclair");

        pollStation.vote("Alice");
        assertEq(pollStation.getVote("Alice"), 1);

        vm.expectRevert();//why? Because onle one can come from an address
        pollStation.vote("Bob");
        vm.expectRevert();
        pollStation.vote("Alice");//user cant vote multiple times

    }

    function testGetAllVotes() public {
    string[] memory Array = new string[](3);
    Array[0] = "Alice";
    Array[1] = "Bob";
    Array[2] = "Charlie";

    pollStation.addCandidate(Array);

    // Step 2: Simulate 3 voters
    address voter1 = address(0x1);
    address voter2 = address(0x2);
    address voter3 = address(0x3);

    vm.prank(voter1);
    pollStation.vote("Alice");

    vm.prank(voter2);
    pollStation.vote("Bob");

    vm.prank(voter3);
    pollStation.vote("Charlie");

    // Step 3: Call getAllVotes
    (string[] memory names, uint256[] memory counts) = pollStation.getAllVotes();

    // Step 4: Assert correctness
    assertEq(names.length, 3);
    assertEq(counts.length, 3);

    assertEq(names[0], "Alice");
    assertEq(counts[0], 1);

    assertEq(names[1], "Bob");
    assertEq(counts[1], 1);

    assertEq(names[2], "Charlie");
    assertEq(counts[2], 1);
}






    
}