// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// 引入OpenZeppelin 的ERC20的实现
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// ERC20标准代币合约
contract MyERC20Token is ERC20 {
    constructor(uint256 initialSupply) ERC20("MyERC20Token", "MET") {
        _mint(msg.sender, initialSupply);
    }
}

// 钱包合约
contract Wallet {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    /**
     * @dev 存入代币到钱包合约
     * @param tokenAddress 代币合约地址（实现了 IERC20 接口）
     * @param amount 存入的代币数量
     *
     * 注意：调用者（通常为钱包 owner）需要先调用相应代币合约的 approve() 函数，
     * 授权钱包合约可以从其账户转出指定数量的代币。
     */
    function depositToken(address tokenAddress, uint256 amount) public {
        require(msg.sender == owner, "Wallet: Only owner can deposit tokens");
        bool success = IERC20(tokenAddress).transferFrom(
            msg.sender,
            address(this),
            amount
        );
        require(success, "Wallet: Token transferFrom failed");
    }

    /**
     * @dev 从钱包合约中提取代币
     * @param tokenAddress 代币合约地址（实现了 IERC20 接口）
     * @param amount 提取的代币数量
     */
    function withdrawToken(address tokenAddress, uint256 amount) public {
        require(msg.sender == owner, "Wallet: Only owner can withdraw tokens");
        bool success = IERC20(tokenAddress).transfer(owner, amount);
        require(success, "Wallet:Token transfer failed");
    }

    /**
     * @dev 查询钱包合约中指定代币的余额
     * @param tokenAddress 代币合约地址
     * @return 返回钱包中该代币的余额
     */
    function getTokenBalance(address tokenAddress)
        public
        view
        returns (uint256)
    {
        return IERC20(tokenAddress).balanceOf(address(this));
    }
}
