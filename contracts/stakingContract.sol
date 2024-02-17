// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.9;


import "./IErc20.sol";
contract StakingContract{

    address owner; 
    uint public immutable rewardsPerHour = 1000; 
     uint public totalStaked = 0;
     mapping (address => uint) public balanceOf;
     mapping (address => uint) public lastUpdated;

    constructor(address owner_){
        owner = owner_;
    }


    event Deposit(address address_, uint amount_);



    function deposit(uint amount_) external {
    IERC20(owner).transferFrom(msg.sender, address(this), amount_);
     balanceOf[msg.sender] += amount_;
     lastUpdated[msg.sender] = block.timestamp;
       totalStaked += amount_;
       emit Deposit(msg.sender, amount_);

    }

    function totalRewards() external view returns (uint) {
  return _totalRewards();
}

function _totalRewards() internal view returns (uint) {
  return  IERC20(owner).balanceOf(address(this)) - totalStaked;
}



}