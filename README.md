# ICO CrowdSale

#### Token Deployed - HALLO

\*\* https://rinkeby.etherscan.io/address/0x7ea764ec6840f92ae9fd7b2bbedca0b036cfc211

\*\* address: 0x7ea764Ec6840f92aE9fd7b2BBedca0b036cFC211

### ICO contract deployed -

\*\* https://rinkeby.etherscan.io/address/0xaabc13a52d26851c49c419ead2f5c4598c8cc9a8

\*\* address: 0xaABc13a52d26851C49c419ead2f5C4598C8cc9a8

#### Used chainLink pricefeed to fetch eth/Usd conversion (rinkeby)

Steps:

1. Deploy the Token Contract - HALLO.sol (rinkeby)
   a) total supply of token will be in the owner deployed address.
2. Deploy the ICO Contract - CrowdSale.sol
3. Set CrowdSale address in hallo to deployed ico contract address.
4. Transfer all the token to Ico Contract - from owner deployed.
5. Start PreSale by setting the PreSale function. (onlyOwner)
6. use the fallback function property to recieve ether into contract and send token back.
7. After the preSale ,set the Stop the preSale function.(onlyOwner)
8. repeat the same for other seedSale and finalSale of token.
9. Set the finalTokenUSD value before starting the finalSale.
10. set the icoComplete function to stop the ICO token distribution.
11. Transfer the ether into owner address from the contract using Extractether function.
