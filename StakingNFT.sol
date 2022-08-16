// SPDX-License-Identifier: MIT

pragma solidity ^0.8.15;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract StakingNFT is ERC721, ERC721Burnable, Ownable {
    constructor() ERC721('TOKENVERSE', 'SOL') {}
    
    uint256 public totalSupply;

    function safeMint(address to) public{
        totalSupply++;
        _safeMint(to, totalSupply); // (address to, uint tokenId)
    }
}