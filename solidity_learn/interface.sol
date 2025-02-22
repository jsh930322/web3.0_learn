// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 定义 IVault 接口
interface IVault {
    // 存款函数
    function deposit(uint256 amount) external payable;

    // 取款函数
    function withdraw(uint256 amount) external;

    // 查询余额函数
    // function balanceOf(address user) external view returns (uint256);
}

// 实现 IVault 接口的 Bank 合约
contract Bank is IVault {
    // 用户余额映射
    mapping(address => uint256) public balances;

    // 存款事件
    event Deposited(address indexed user, uint256 amount, uint256 timestamp);

    // 取款事件
    event WithDrawn(address indexed user, uint256 amount, uint256 timestamp);

    function deposit(uint256 amount) public payable override {
        require(amount > 0, "Deposit amount must be greater than 0");
        balances[msg.sender] += msg.value;
        emit Deposited(msg.sender, msg.value, block.timestamp);
    }

    function withdraw(uint256 amount) external override {
        require(amount > 0, "Withdrawal amount must be greater than 0");
        require(balances[msg.sender] > amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        // 转账操作 使用call代替transfer以适应不同gas需求
        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "Transfer failed");
        emit WithDrawn(msg.sender, amount, block.timestamp);
    }

    function getTotalDeposits() external view returns (uint256) {
        return address(this).balance;
    }
}
