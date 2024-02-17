// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.9;


import "./IErc20.sol";
contract StakingContract{

    address owner; 
    uint public  rewardsPerHour = 1000; 
     uint public totalStaked = 0;
     mapping (address => uint) public balanceOf;
     mapping (address => uint) public lastUpdated;
     uint256 constant scaleFactor = 1e18;

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

function rewards(address address_) external view returns (uint) {
  return _rewards(address_);
}

function _rewards(address address_) internal view returns (uint) {
return ((block.timestamp - lastUpdated[address_]) * balanceOf[address_] * scaleFactor) / (rewardsPerHour * 1 hours);
}





}