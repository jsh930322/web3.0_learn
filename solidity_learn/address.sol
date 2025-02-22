// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

contract addressDemo {
    address myAddress = 0x1234567890123456789012345678901234567890;
    address payable payableAddress = payable(myAddress);

    uint256 balance = myAddress.balance; // 获取地址余额（单位：wei）

    // 白名单机制
    mapping(address => bool) public whiteList;

    mapping(address => uint256) public balances;

    function addToWhiteList(address _address) public {
        whiteList[_address] = true;
    }

    function isWhiteListed(address _address) public view returns (bool) {
        return whiteList[_address];
    }

    // 授权支付合约
    // function pay(address payable recipient) public payable {
    //     require(whitelist[recipient], "Recipient is not whitelisted.");
    //     recipient.transfer(msg.value);
    // }

    function withdrow(uint256 amount) public {
        require(balances[msg.sender] >= amount, "Insufficient balance.");
        // 更新余额
        balances[msg.sender] -= amount;
        // 转账
        (bool success, ) = msg.sender.call{value: amount}("");
        payable(msg.sender).transfer(amount);
        require(success, "Transfer failed.");
    }

    // 存款函数
    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    // 查询余额
    function check() public view returns (uint256) {
        return balances[msg.sender];
    }
}
