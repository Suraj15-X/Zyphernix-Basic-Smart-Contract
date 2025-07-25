// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract TreasureChest {

    address public admin;
    uint public totalTreasure;

    constructor() {
        admin = msg.sender;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Not admin");
        _;
    }

    function addTreasure(uint amount) public onlyAdmin {
        totalTreasure += amount;
    }

    mapping(address => uint) public approvedAmount;
    mapping(address => bool) public hasWithdrawn;

    function approveWithdrawal(address user, uint amount) public onlyAdmin {
        approvedAmount[user] = amount;
    }

    function claimTreasure() public {
        require(approvedAmount[msg.sender] > 0, "Not approved");
        require(!hasWithdrawn[msg.sender], "Already claimed");
        require(totalTreasure >= approvedAmount[msg.sender], "Insufficient treasure");

        totalTreasure -= approvedAmount[msg.sender];
        hasWithdrawn[msg.sender] = true;
    }

    function resetClaimStatus(address user) public onlyAdmin {
        hasWithdrawn[user] = false;
    }

    function changeAdmin(address newAdmin) public onlyAdmin {
        admin = newAdmin;
    }
}
