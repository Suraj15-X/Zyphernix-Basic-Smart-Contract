// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract SaveMyName{
    string public Name;
    string public Bio;

    function details(string memory _Name, string memory _Bio) public{
        Name = _Name; Bio = _Bio;

    }
}
