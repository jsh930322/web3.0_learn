// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract CustomErrorExample {
    error Unauthorized(address caller);

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function restrictedFunction() public view {
        if (msg.sender != owner) {
            revert Unauthorized(msg.sender);
        }
    }

    function getValue() public pure returns (uint256) {
        return 42;
    }

    function willRevert() public pure {
        revert("This function always fails");
    }
}

contract TryCatchExample {
    CustomErrorExample customErrorExample;

    constructor() {
        customErrorExample = new CustomErrorExample();
    }

    function tryCatchTest() public view returns (uint256, string memory) {
        try customErrorExample.getValue() returns (uint256 value) {
            return (value, "success");
        } catch {
            return (0, "failed");
        }
    }

    function tryCatchWithRevert() public view returns (string memory) {
        try customErrorExample.willRevert() {
            return "This will not execute";
        } catch Error(string memory reason) {
            return reason;
        } catch {
            return "Unknow reason";
        }
    }
}
