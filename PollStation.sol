// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PollStation {
    string[5] public candidate = ["Alice", "Bob", "Charlie", "David", "Eve"];
    uint256[5] public votes;

    mapping(address => uint256) public voted;

    function voting(uint students) public {
        require(students < 5, "Invalid candidate");
        require(voted[msg.sender] == 0, "Already voted");
        votes[students] += 1;
        voted[msg.sender] = 1;
    }

    function getVotes(uint students) public view returns (uint256) {
        require(students < 5, "Invalid candidate");
        return votes[students];
    }
}
