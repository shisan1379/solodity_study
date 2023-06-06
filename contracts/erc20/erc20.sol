// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./IERC20.sol";

contract ERC20 is IERC20 {
    /**
     * 用override修饰public变量，会重写继承自父合约的与变量同名的getter函数，
     * 比如IERC20中的balanceOf()函数。
     */
    mapping(address => uint256) public override balanceOf;

    //授权额度
    mapping(address => mapping(address => uint256)) public override allowance;

    //erc20 标准
    uint256 public override totalSupply; // 代币总供给

    string public name; // 名称
    string public symbol; // 代号

    uint8 public decimals = 18; // 小数位数

    constructor(string memory name_, string memory symbol_) {
        name = name_;
        symbol = symbol_;
    }

    //转移
    function transfer(address recipient, uint256 amount)
        external
        override
        returns (bool)
    {
        //发送者减少
        balanceOf[msg.sender] -= amount;
        //接受者增加
        balanceOf[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    //授权
    //被授权方，可以支配代币的数量
    function approve(address spender, uint256 amount)
        external
        override
        returns (bool)
    {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    //被授权方转账
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external override returns (bool) {
        //减掉授权代币数量
        allowance[sender][msg.sender] -= amount;
        
        balanceOf[sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }

    //  铸造
    function mint(uint256 amount) external {
        balanceOf[msg.sender] += amount;
        totalSupply += amount;
        emit Transfer(address(0), msg.sender, amount);
    }

    //销毁
    function burn(uint256 amount) external {
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }
}
