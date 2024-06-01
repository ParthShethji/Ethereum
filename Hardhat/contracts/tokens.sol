// SPDX-License-Identifier: MIT 
pragma solidity >=0.5.0 < 0.9.0;

contract token {
    string public name = "Parth";
    string public Token = "P";
    uint public totalsupply = 100;
    address public owner;

    mapping (address => uint) balance;
    constructor() {
        balance[msg.sender]=totalsupply;
        owner=msg.sender;
    }

    function transfer (uint amount, address to) external{
        require(balance[msg.sender]>=amount, "not enough amount");
        balance[msg.sender]-=amount;
        balance[to]+=amount;
    }
    function balview(address account) external view returns(uint256) {
        return balance[account];
    }
}