// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.9;


import "./IErc20.sol";
contract StakingContract{

    address owner; 
    uint public immutable rewardsPerHour = 1000; 
     uint public totalStaked = 0;
     mapping (address => uint) public balanceOf;

    constructor(address owner_){
        owner = owner_;
    }

    function deposit(uint amount_) external {
    IERC20(owner).transferFrom(msg.sender, address(this), amount_);
     balanceOf[msg.sender] += amount_;
}



}