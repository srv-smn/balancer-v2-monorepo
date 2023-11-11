// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

import "@balancer-labs/v2-solidity-utils/contracts/openzeppelin/Ownable.sol";

contract CustomFeeAuthorizer is Ownable {

    mapping(address => bool) private authorized;
    bool public isCustomFeeEnabled = false;

    function isCustomFeeAuthorised(address _authAdd) public view returns(bool _isAuth){
        _isAuth = (authorized[_authAdd] ||  owner() == _authAdd) ;
    }

    function addAuthorized(address _toAdd) onlyOwner public {
        require(_toAdd != address(0));
        require(isCustomFeeEnabled,"Custom Fee Not Enabled");
        authorized[_toAdd] = true;
    }

    function removeAuthorized(address _toRemove) onlyOwner public {
        require(_toRemove != msg.sender);
        authorized[_toRemove] = false;
    }

    function enableCustomFee() onlyOwner() internal {
        require(!isCustomFeeEnabled, "Already Enabled");
        isCustomFeeEnabled = true;
    }

}