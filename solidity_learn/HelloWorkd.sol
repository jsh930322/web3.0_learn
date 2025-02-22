// SPDX-License-Identifier: MIT
// pragma solidity >=0.8.0 <0.9.0;
pragma solidity ^0.8.0;

contract HelloWorldDemo {
    string public hell = "hello web3!";

    // 基本类型
    int256 public i = 11;

    uint256 public a = 1 * 2 ** 256 - 1; // 没有符号，-+

    bool public flag = false;
    bool public flag1 = true;

    address public add = 0x552B075F02568781D9336A141AE4D786Dc53e118;
    bytes2 public b2 = 0x000;
    bytes3 public b3 = hex"100000";

    enum Status {
        NEW,
        OLD
    }

    // 引用类型
    // 数组
    int256[] arr;
    uint256[] arr1;
    string[] arr2;
    bytes[] arr3;
    // 字符串
    string public str = "aaa";

    struct Person {
        uint256 age;
        string name;
        bool sex;
    }

    Person public zood = Person(18, "andy", true);

    Person public p = Person({age: 11, sex: false, name: "tony"});
}
