// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
import "@openzeppelin/contracts-ethereum-package/contracts/token/ERC777/IERC777Recipient.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/token/ERC777/IERC777.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/introspection/IERC1820Registry.sol";

contract Merit is IERC777Recipient {
    mapping(address => uint256) public givers;
    address _owner;
    // 声明一个类型为IERC777的变量_token,用来存储ERC777代币合约的地址，该合约后续将调用该代币合约的方法
    IERC777 _token;
    // ERC1820 注册表用于注册和查询合约支持哪些接口，实现了ERC777标准的接口注册机制
    IERC1820Registry private _erc1820 =
        IERC1820Registry(0x1820a4B7618BdE71Dce8cdc73aAB6C95905faD24);
    //  该常量用于在ERC1820注册表中注册当前合约为ERC777代币的接收者
    bytes32 private constant TOKENS_RECIPIENT_INTERFACE_HASH =
        0xb281fc8c12954d22544db45de3159a39272895b169a852b314f9cc762e44c53b;

    constructor(IERC777 token) public {
        _erc1820.setInterfaceImplementer(
            address(this),
            TOKENS_RECIPIENT_INTERFACE_HASH,
            address(this)
        );
        _owner = msg.sender;
        _token = token;
    }

    function tokensReceived(
        address operator,
        address from,
        address to,
        uint256 amount,
        bytes calldata userData,
        bytes calldata operatorData
    ) external override {
        givers[from] += amount;
    }

    // 功德箱管理员提取代币
    function withdraw() external {
        require(msg.sender == _owner, "no permission");
        uint256 balance = _token.balanceOf(address(this));
        _token.send(_owner, balance, "");
    }
}
