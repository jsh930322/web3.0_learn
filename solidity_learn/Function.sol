// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Function {
    function returnMany() public pure returns (uint256, bool, uint256) {
        return (1, true, 2);
    }

    function named() public pure returns (uint256 x, bool b, uint256 y) {
        return (1, true, 2);
    }

    // 返回值可以直接赋值给他们的名字
    // 在这种情况下，可以省略return语句
    function assigned() public pure returns (uint256 x, bool b, uint256 y) {
        x = 1;
        b = false;
        y = 2;
    }

    // 调用另一个返回多个值的函数时，可以使用解构赋值
    function destructuringAssignments()
        public
        pure
        returns (uint256, bool, uint256, uint256, uint256)
    {
        (uint256 i, bool b, uint256 j) = returnMany();
        // 可以忽略某些值（使用逗号跳过）
        (uint256 x, , uint256 y) = (4, 5, 6);

        return (i, b, j, x, y);
    }

    // 映射不能用作输入或输出

    // 数组可以用作输入
    function arrayInput(uint256[] memory _arr) public {}

    // 数组可以用作输出

    uint256[] public arr;

    function arrayOutput() public view returns (uint256[] memory) {
        return arr;
    }
}

// 使用键值对输入调用函数
contract XYZ {
    function someFuncWithManyInputs(
        uint256 x,
        uint256 y,
        uint256 z,
        address a,
        bool b,
        string memory c
    ) public pure returns (uint256) {}

    function callFunc() external pure returns (uint256) {
        return someFuncWithManyInputs(1, 2, 3, address(0), true, "c");
    }

    function callFuncWithKeyValue() external pure returns (uint256) {
        return
            someFuncWithManyInputs({
                a: address(0),
                b: true,
                c: "c",
                x: 1,
                y: 2,
                z: 3
            });
    }
}
