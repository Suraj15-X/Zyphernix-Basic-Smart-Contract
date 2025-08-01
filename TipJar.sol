// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract TipJar {

    address public owner;

    mapping(address => uint) public etherTips;
    mapping(address => uint) public usdTips;
    mapping(address => uint) public eurTips;

    uint public totalEthGet;
    uint public usdToWeiRate = 0.0005 ether; 
    uint public eurToWeiRate = 0.00055 ether;

    constructor() {
        owner = msg.sender;
    }

    function tipEther() public payable {
        require(msg.value > 0, "Send some ETHER");
        etherTips[msg.sender] += msg.value;
        totalEthGet += msg.value;
    }

    function UsdTip(uint usdAmount) public {
        uint weiEquivalent = usdAmount * usdToWeiRate;
        usdTips[msg.sender] += weiEquivalent;
    }

    function EurTip(uint eurAmount) public {
        uint weiEquivalent = eurAmount * eurToWeiRate;
        eurTips[msg.sender] += weiEquivalent;
    }

    function getEthBalance() public view returns (uint) {
        return address(this).balance;
    }

    function withdrawAll() public {
        require(msg.sender == owner, " owner can withdraw");
        payable(owner).transfer(address(this).balance);
    }

    function getUserSummary(address user) public view returns (
        uint etherAmount,
        uint usdAmount,
        uint eurAmount
    ) 
    {
        etherAmount = etherTips[user];
        usdAmount = usdTips[user];
        eurAmount = eurTips[user];
    }
}
