// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// 代币接口
interface IToken {
    function transfer(address to, uint256 amount) external returns (bool);
}

contract MyToken is IToken {
    mapping(address => uint256) public balanceOf;

    constructor(uint256 initialSupply) {
        balanceOf[msg.sender] = initialSupply;
    }

    function transfer(address to, uint256 amount)
        external
        override
        returns (bool)
    {
        require(balanceOf[msg.sender] >= amount, "Insufficient balance");
        balanceOf[msg.sender] -= amount;
        balanceOf[to] += amount;
        return true;
    }
}

contract Reward {
    IToken immutable token;

    constructor(IToken _token) {
        token = _token;
    }

    function setBonus(address user) public {
        token.transfer(user, 100);
    }
}
