// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract DataHandling {
    uint256[] public data; // 存储在storage中的动态数组

    // 降memory中的数组内容复制到storage中的data数组
    function updateDate(uint256[] memory newDate) public {
        data = newDate; // 从memory到storage的复制，创建了独立的拷贝
    }

    //  返回storage中的data数组
    function getDate() public view returns (uint256[] memory) {
        return data;
    }

    // 修改storage中的data数组指定索引的值
    function modifyStorageData(uint256 index, uint256 val) public {
        require(index < data.length, "Index out of bounds");
        data[index] = val;
    }

    // 尝试修改传入的memory数组，并返回修改后的数组
    function modifyMemoryData(uint256[] memory arr)
        public
        pure
        returns (uint256[] memory)
    {
        if (arr.length > 0) {
            arr[0] = 888;
        }
        return arr;
    }
}
