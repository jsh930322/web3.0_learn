// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Immutable {
    // 不可变量可以在构造函数中修改，之后就不能修改了
    address public immutable add;

    uint256 public immutable My_INT;

    constructor(uint256 _My_INT) {
        add = msg.sender;
        My_INT = _My_INT;
    }
}
