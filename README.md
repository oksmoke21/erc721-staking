This is an ERC721 staking contract for users to stake their ERC721 tokens and earn passive income in the form of ERC20 tokens.

Steps to use smart contract-

1. Deploy StakingNFT.sol, which is the contract StakingNFT that allows users to mint and burn ERC721 tokens based on the OpenZeppelin library.
2. Note the contract address of the deployed StakingNFT.sol contract.
3. Deploy StakingToken.sol, which is the contract StakingNFT accepts the above address as constructor argument.
4. StakingToken now becomes the managing contract for ERC721 tokens generated via StakingNFT, hence it must be set as an approved operater.
5. Call the setApprovalForAll function in StakingNFT, with fields: operator = StakingToken contract's address, approved = true.
6. ERC1155 tokens minted in StakingNFT can now be staked and unstaked by their owner in StakingToken contract.
7. Users can call function calculateTokens to calculate the ERC20 tokens that will be received upon unstaking their tokens based upon the staked time by passing the required token's tokenId as function parameter
