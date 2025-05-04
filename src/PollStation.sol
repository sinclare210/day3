// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract PollStation {
    string[] public candidateDetails;

    mapping(string => bool) private candidateExists;

    mapping(string => uint256) public voteCount;

    mapping(address => bool) public voted;

    function addCandidate(string[] memory _candidateName) public {
        for (uint256 i = 0; i < _candidateName.length; i++) {
            require(bytes(_candidateName[i]).length > 0, "Invalid Candidate Name");
            require(candidateExists[_candidateName[i]] == false, "Invalid Candidate Name");
            candidateDetails.push(_candidateName[i]);
            voteCount[_candidateName[i]] = 0;
            candidateExists[_candidateName[i]] = true;
        }
    }

    function vote(string memory _name) public {
        require(!voted[msg.sender], "voted");

        require(candidateExists[_name] == true, "Invalid Candidate Name");

        voteCount[_name]++;

        voted[msg.sender] = true;
    }

    function getCandidate() public view returns (string[] memory) {
        return candidateDetails;
    }

    function getVote(string memory _name) public view returns (uint256) {
        require(candidateExists[_name], "Candidate does not exist");
        return voteCount[_name];
    }

    function getAllVotes() public view returns (string[] memory, uint256[] memory) {
        uint256[] memory counts = new uint256[](candidateDetails.length);
        for (uint256 i = 0; i < candidateDetails.length; i++) {
            counts[i] = voteCount[candidateDetails[i]];
        }
        return (candidateDetails, counts);
    }
}
