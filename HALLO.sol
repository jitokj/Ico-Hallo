// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./@openzeppelin/contracts@4.1.0/token/ERC20/ERC20.sol";

// Hallo Token ERC 20 Inherited from ERC20
contract Hallo is ERC20 {
    address public crowdsaleAddress;
    address public owner;
    modifier onlyCrowdsale {
        require(msg.sender == crowdsaleAddress);
        _;
    }
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    constructor() ERC20("Hallo", "HAL") {
        owner = msg.sender;
        _mint(msg.sender, 100000000 * 10**18);
    }

    // setting ico Contract address

    function setCrowdsale(address _crowdsaleAddress) public onlyOwner {
        require(_crowdsaleAddress != address(0));
        crowdsaleAddress = _crowdsaleAddress;
    }

    // transfer tokens to users who pay ether
    function buyTokens(address _receiver, uint256 _amount)
        public
        onlyCrowdsale
    {
        require(_receiver != address(0));
        require(_amount > 0);
        transfer(_receiver, _amount);
    }
}
