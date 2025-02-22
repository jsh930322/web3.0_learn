// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract EtherUnits {
    uint256 public oneWei = 1 wei;

    bool public isOneWei = (oneWei == 1);

    uint256 public oneGwei = 1 gwei;

    bool public isOneGwei = (oneGwei == 1e9); // 1gwei 等于 10^9 wei

    uint256 public oneEther = 1 ether;

    bool public isOnweEther = (oneEther == 1e18); // 1ehter 等于10^18 wei
}
