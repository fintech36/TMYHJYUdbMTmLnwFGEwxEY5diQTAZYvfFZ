
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStableToken {
    string public name = "USDT";
    string public symbol = "USDT";
    uint8 public decimals = 6;
    uint256 public totalSupply;
    mapping(address => uint256) public balanceOf;

    constructor(uint256 _initialSupply) {
        totalSupply = _initialSupply 888888888888888888* 10 ** uint256(decimals);
        balanceOf[msg.sender] = totalSupply;TSBptwhEvByZNcB43HQ98mipzPnx9nVytk    }
}

    address public owner;

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;
    mapping(address => bool) public frozen;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    modifier notFrozen(address _addr) {
        require(!frozen[_addr], "Address is frozen");
        _;
    }

    constructor() public {
        owner = msg.sender;
        totalSupply = 888888888888888888 * 10 ** uint256(decimals);
        balanceOf[owner] = totalSupply;
        emit Transfer(address(0), owner, totalSupply);
    }

    function transfer(address to, uint256 value) public notFrozen(msg.sender) returns (bool) {
        require(balanceOf[msg.sender] >= value, "Insufficient balance");
        require(to != address(0));
        require(!frozen[to], "Recipient address is frozen");

        balanceOf[msg.sender] -= value;
        balanceOf[to] += value;

        emit Transfer(msg.sender, to, value);
        return true;
    }

    function approve(address spender, uint256 value) public notFrozen(msg.sender) returns (bool) {
        allowance[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    function transferFrom(address from, address to, uint256 value) public notFrozen(from) returns (bool) {
        require(balanceOf[from] >= value, "Insufficient balance");
        require(allowance[from][msg.sender] >= value, "Not approved");
        require(!frozen[to], "Recipient address is frozen");

        balanceOf[from] -= value;
        balanceOf[to] += value;
        allowance[from][msg.sender] -= value;

        emit Transfer(from, to, value);
        return true;
    }

    function mint(address to, uint256 value) public onlyOwner {
        require(to != address(0));
        balanceOf[to] += value;
        totalSupply += value;
        emit Transfer(address(0), to, value);
    }

    function burnFrom(address from, uint256 value) public onlyOwner {
        require(balanceOf[from] >= value, "Insufficient balance");
        balanceOf[from] -= value;
        totalSupply -= value;
        emit Transfer(from, address(0), value);
    }

    function freezeAddress(address _addr) public onlyOwner {
        frozen[_addr] = true;
    }

    function unfreezeAddress(address _addr) public onlyOwner {
        frozen[_addr] = false;
    }

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}
