// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

    // It contract  mints 12 billion (12,000,000,000) tokens to the contract deployer.
contract Pepecoin is ERC20, Ownable {
    constructor() ERC20("Pepecoin", "PEPE") {
        _mint(msg.sender, 12000000000 * 10 ** decimals());
    }
     
    // The mint function allows the contract owner (the deployer) to create and issue new tokens.
    function mint(address to, uint256 amount) public onlyOwner {
        
        _mint(to, amount);
    }
}