// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// modifier 修饰符 是solidity提供的一种特殊函数，可用于在执行翻书前后插入额外的逻辑
// 常用于访问控制，输入验证，防止重入攻击
contract FunctionModifier {
    // 这些变量用于演示如何使用函数修饰符
    address public owner;
    uint256 public x = 10;
    bool public locked;

    constructor() {
        // 将合约的所有者设置为交易的发送者
        owner = msg.sender;
    }

    // 修饰符：检查调用者是否为合约所有者
    modifier onlyOwner() {
        require(msg.sender == owner, "不是所有者");
        // 下划线 _ 是solidity中的特殊符号
        // 表示继续执行剩余的代码
        _;
    }

    // 修饰符可以接受参数。此修饰符检查传入的地址是否为零地址
    modifier validAddress(address _addr) {
        require(_addr != address(0), "无效地址");
        _;
    }

    function changeOwner(
        address _newOwner
    ) public onlyOwner validAddress(_newOwner) {
        owner = _newOwner;
    }

    // 修饰符可以在函数执行前或执行后调用。
    // 该修饰符防止函数在执行过程中被再次调用（防止重入攻击）。
    modifier noReentrancy() {
        require(!locked, "防止重入攻击");

        locked = true;
        _;
        locked = false;
    }

    function decrement(uint256 i) public noReentrancy {
        x -= i;

        if (i > 1) {
            decrement(i - 1);
        }
    }
}
