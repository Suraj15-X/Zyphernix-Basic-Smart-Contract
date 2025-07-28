// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract SimpleIOU {
    mapping(address => uint) public balances;
    mapping(address => mapping(address => uint)) public iou; 

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function lend(address friend, uint amount) public {
        require(balances[msg.sender] >= amount, "Not enough balance to lend");

        balances[msg.sender] -= amount;
        iou[friend][msg.sender] += amount; 
    }

    function repay(address lender) public payable {
        require(iou[msg.sender][lender] > 0, "No debt to repay");
        require(msg.value <= iou[msg.sender][lender], "Paying more than you get");

        iou[msg.sender][lender] -= msg.value;
        balances[lender] += msg.value;
    }

    function getIOU(address borrower) public view returns (uint) {
        return iou[borrower][msg.sender];
    }

    function withdraw(uint amount) public {
        require(balances[msg.sender] >= amount, "Not enough balance");

        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }
}
