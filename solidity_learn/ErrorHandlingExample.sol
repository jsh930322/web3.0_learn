// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract ErrorHandlingExample {
    uint256 public balance;
    address public owner;

    constructor() public {
        owner = msg.sender;
    }

    function transferOwnership(address newOwner) public {
        require(msg.sender == owner, "Only the owner can transfer ownership."); // 检查调用者是否为合约所有者
        owner = newOwner;
    }

    function checkBalance(uint256 a, uint256 b) public pure returns (uint256) {
        uint256 result = a + b;
        assert(result >= a); // 检查溢出错误
        return result;
    }

    function sendHalf(address payable addr) public payable {
        require(msg.value % 2 == 0, "Even value required");
        uint256 balanceBeforeTransfer = address(this).balance;
        addr.transfer(msg.value / 2);
        assert(address(this).balance == balanceBeforeTransfer - msg.value / 2); // 检查内部错误或逻辑错误， 如果断言失败，状态将回滚，并消耗所有剩余的Gas
    }

    function checkValue(uint256 value) public pure {
        if (value > 0) {
            revert("Value cannot exceed 10");// 可以用于立即停止执行并回
        }
    }
}
