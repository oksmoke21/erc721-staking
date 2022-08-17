// SPDX-License-Identifier: MIT

pragma solidity ^0.8.15;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract StakingToken is ERC20, ERC721Holder, Ownable{
    IERC721 public nft;
    mapping(uint256 => address) public nftOwnerOf;
    mapping(uint256 => uint256) public nftStakedAt;

    constructor(address _nft) ERC20('TOKENVERSE', 'SOL') {
        nft = IERC721(_nft);
    }

    function stakeNFT(uint tokenId) external{
        nft.safeTransferFrom(msg.sender, address(this), tokenId);
        nftOwnerOf[tokenId] = msg.sender;
        nftStakedAt[tokenId] = block.timestamp;
    }

    function unstakeNFT(uint tokenId) external{
        require(nftOwnerOf[tokenId] == msg.sender);
        _mint(msg.sender, calculateTokens(tokenId));
        nft.safeTransferFrom(address(this), msg.sender, tokenId);
        delete nftOwnerOf[tokenId];
        delete nftStakedAt[tokenId];
    }

    function calculateTokens(uint tokenId) public view returns(uint256){
        uint timeElapsed = block.timestamp - nftStakedAt[tokenId];
        uint interestRate;
        if(timeElapsed <= 30 days)
        {
            interestRate = 5; // 5% interest rate for upto 1 month (30 days)
        }
        else if(timeElapsed <= 26 weeks)
        {
            interestRate = 10; // 10% interest rate for upto 6 months
        }
        else if(timeElapsed <= 52 weeks)
        {
            interestRate = 15; // 15% interest rate for upto 1 year (52 weeks)
        }
        else interestRate = 15; // 15% fixed interest rate after 1 year
        return (timeElapsed*interestRate)*(10**18)/100; // ERC20: 1 token = 10^18 subtokens
    }
}
