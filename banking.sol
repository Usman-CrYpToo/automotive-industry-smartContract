// SPDX-License-Identifier: MIT

pragma solidity >= 0.8.0;

contract banking{
    address  payable public  owner;

    constructor(){
        owner = payable(msg.sender);
    }
     mapping(address => bool) public access;
     mapping(address => uint) public balance;
    function grantPermission(address user) external {
         require(msg.sender == owner, "you are not the owner");
        access[user] = !(access[user]);
    }
    
    function deposit() payable external{
        require(access[msg.sender],"you dont have the access to deposit");
        require(msg.value > 0,"the value must be greater than 0");
        balance[msg.sender] += msg.value;
    }
    
    function withdraw(uint value) payable external{
         require((value * (10**18)) <= balance[msg.sender],"insuffient balance");
         balance[msg.sender] -= (value * (10**18));
         (payable (msg.sender)).transfer(value * (10**18));
    }
    function transfer(address payable receiver,uint value) payable external {
        require((value * (10**18)) <= balance[msg.sender],"insuffient balance");
        require(access[receiver],"your receiver dont have the access");
        balance[msg.sender] -= (value * (10**18));
        receiver.transfer(value * (10**18));
    }

    function changeOwner(address payable newOwner) external {
        require(msg.sender == owner,"you are not the owner");
        owner = newOwner;
    }
}// SPDX-License-Identifier: MIT

pragma solidity >= 0.8.0;

contract banking{
    address  payable public  owner;

    constructor(){
        owner = payable(msg.sender);
    }
     mapping(address => bool) public access;
     mapping(address => uint) public balance;
    function grantPermission(address user) external {
         require(msg.sender == owner, "you are not the owner");
        access[user] = !(access[user]);
    }
    
    function deposit() payable external{
        require(access[msg.sender],"you dont have the access to deposit");
        require(msg.value > 0,"the value must be greater than 0");
        balance[msg.sender] += msg.value;
    }
    
    function withdraw(uint value) payable external{
         require((value * (10**18)) <= balance[msg.sender],"insuffient balance");
         balance[msg.sender] -= (value * (10**18));
         (payable (msg.sender)).transfer(value * (10**18));
    }
    function transfer(address payable receiver,uint value) payable external {
        require((value * (10**18)) <= balance[msg.sender],"insuffient balance");
        require(access[receiver],"your receiver dont have the access");
        balance[msg.sender] -= (value * (10**18));
        receiver.transfer(value * (10**18));
    }

    function changeOwner(address payable newOwner) external {
        require(msg.sender == owner,"you are not the owner");
        owner = newOwner;
    }
}