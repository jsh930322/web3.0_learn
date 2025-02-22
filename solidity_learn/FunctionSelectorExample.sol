// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract FunctionSelectorExample {
    // 状态变量，用来存储函数选择器
    bytes4 public storedSelector;

    function square(uint256 x) public pure returns (uint256) {
        return x * x;
    }

    function double(uint256 x) public pure returns (uint256) {
        return 2 * x;
    }

    // 返回函数选择器
    function getSquareSelector() external pure returns (bytes4) {
        return this.square.selector;
    }

    function getDoubleSelector() external pure returns (bytes4) {
        return bytes4(keccak256("double(uint256)"));
    }

    function select(bytes4 selector, uint256 x) external returns (uint256 z) {
        (bool success, bytes memory data) = address(this).call(
            abi.encodeWithSelector(selector, x)
        );

        require(success, "Function call Failed");
        z = abi.decode(data, (uint256));
    }

    // 存储选择器到状态变量中
    function storeSelector(bytes4 selector) public {
        storedSelector = selector;
    }

    function executeStoredFuncton(uint256 x) public returns (uint256) {
        require(storedSelector != bytes4(0), "Selector not set");
        (bool success, bytes memory data) = address(this).call(
            abi.encodeWithSelector(storedSelector, x)
        );

        require(success, "Function call failed");
        return abi.decode(data, (uint256));
    }
}
