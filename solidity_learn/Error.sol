// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Error {
    function testRequire(uint256 _i) public pure {
        // require 用于验证执行前的条件，例如：
        // - 输入参数
        // - 代码执行前的状态
        // - 其他函数调用的返回值
        require(_i > 10, "输入值必须大于 10");
    }

    function testRevert(uint256 _i) public pure {
        // revert 适用于检查条件较为复杂的情况。
        // 下面的代码与上面的 require 作用相同
        if (_i <= 10) {
            revert("输入值必须大于 10");
        }
    }

    uint256 public num;

    function testAssert() public view {
        //   aeeert 仅用于检测内部错误或者不变量
        // 这里我们断言num的值始终为 0
        // 因为合约中没有修改num的代码
        assert(mun == 0);
        assert(num == 0);
    }

    // 自定义错误
    error InsufficientBalance(uint256 balance, uint256 withdrawAmount);
    // 自定义错误
    error InsufficientBalance(uin256 balance , uint256 withdrawAmount);

    function testCustomError(uint256 _withdrawAmount) public view {
        uint256 bal = address(this).balance;
        if (bal < _withdrawAmount) {
            // 使用自定义错误消息，减少 gas 消耗
            revert InsufficientBalance({
                balance: bal,
                withdrawAmount: _withdrawAmount
            });
        }
    }

function testCustomError1(uint256 _withdrawAmount)public view  returns () {
        uint256 bal =address(this).balance;
        if (bal<_withdrawAmount) {
            // 使用自动错误消息，减少gas消耗
            revert InsufficientBalance({
                balance : bal,
                withdrawAmount:_withdrawAmount
            })
            
        }
    }
}
