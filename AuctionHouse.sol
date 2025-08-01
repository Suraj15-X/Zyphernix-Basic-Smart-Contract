// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AuctionHouse {
    address public owner;
    uint public auctionEndTime;

    address public highestBidder;
    uint public highestBid;

    bool public ended;

    constructor(uint _biddingTimeInSeconds) {
        owner = msg.sender;
        auctionEndTime = block.timestamp + _biddingTimeInSeconds;
    }

    function bid() public payable {
        require(block.timestamp < auctionEndTime, "Auction has ended");

        require(msg.value > highestBid, "There already is a higher bid");

        highestBid = msg.value;
        highestBidder = msg.sender;
    }

    function endAuction() public {
        require(msg.sender == owner, "Only owner can end the auction");

        require(!ended, "Auction already ended");

        require(block.timestamp >= auctionEndTime, "Auction not yet ended");

        ended = true;

        payable(owner).transfer(highestBid);
    }
}
