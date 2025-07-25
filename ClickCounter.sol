// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ClickCounter {
    uint256 public count;

    function click() public {
        count += 1;
    }

    function decrement() public {
        require(count > 0, "Count can't go below 0");
        count -= 1;
    }
}
