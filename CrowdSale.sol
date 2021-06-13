// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./HALLO.sol";
import "./PriceFeed.sol";

contract CrowdSale is PriceFeed {
  
   bool private icoCompleted;
   int public preSale;
   int public seedSale;
   int public  finalSale;
   
   address public tokenAddress;
   address payable public owner;
   
   uint256 public ethPrice;
   uint256 public tokensToBuyPreSale;
   uint256 public tokensToBuySeedSale;
   uint256 public tokensToBuyFinalSale;
   uint256 private preSaleQuantity = 3e7;
   uint256 private seedSaleQuantity = 5e7;
   uint256 private finalSaleQuantity = 2e7;
   
   uint256 public tokenFinalValueInUSD; // unsigned integer
   
   uint256 public preSaledQuantity;
   uint256 public seedSaledQuantity;
   uint256 public finalSaledQuantity;
   
   Hallo public token;


   
   modifier whenIcoCompleted {
      require(icoCompleted);
      _;
   }
   
    modifier onlyOwner {
      require(msg.sender == owner);
      _;
   }
   
     constructor(address _tokenAddress){
         int chainLinkPrice;
         chainLinkPrice = getThePrice();
         ethPrice = uint256(chainLinkPrice)/1e8;
         tokenAddress = _tokenAddress;
         token = Hallo(_tokenAddress);
         owner = payable(address(msg.sender));
     }
    
    fallback() external payable {
       
    }
  
    receive() external payable {
        buy();
       
       
    }
    
    function afterIcoCompleted() external onlyOwner {
        icoCompleted= true;
    }
    
    /**
    * functions for starting and stopping phases in ico
    */
    
    function startPreSale() onlyOwner external {
        require(preSale == 0 );
        preSale = 1;
    }
    
    function stopPreSale() onlyOwner external {
        require(preSale == 1);
        preSale=0;
    }
    
    function startSeedSale() onlyOwner external {
        require(seedSale == 0);
        seedSale = 1;
    }
    
    function stopSeedSale() onlyOwner external {
        require(seedSale == 1);
        seedSale=0;
    }
    
     function finalSeedSale() onlyOwner external {
        require(finalSale == 0);
        finalSale = 1;
    }
    
    // set tokenValue in USD for finalSale of tokens
    function setFinalTOkenValue(uint256 _tokenFinalValueInUSD) onlyOwner external {
         tokenFinalValueInUSD = _tokenFinalValueInUSD;
    }
    
    
    
    
    function buy() public payable {
        if(preSale == 1){
        preSalebuy(msg.value,msg.sender);
        }
        else if(seedSale == 1){
            seedSalebuy(msg.value,msg.sender);
        }
        else if(finalSale == 1){
            finalSalebuy(msg.value,msg.sender);
        }
        
    }
    
    /*
    * presale function with token value of USD 0.01
    */
    
    function preSalebuy(uint256 _value,address _buyer) private  {
      tokensToBuyPreSale = (_value*ethPrice)/(1e16);
       preSaledQuantity+=tokensToBuyPreSale;
         require(preSaledQuantity<= preSaleQuantity);
         token.buyTokens(_buyer, tokensToBuyPreSale);
   }
   
    /*
    * seedsale function with token value of USD 0.02
    */
    
    function seedSalebuy(uint256 _value,address _buyer) private  {
      tokensToBuySeedSale = ((_value*ethPrice))/(2e16);
       seedSaledQuantity+=tokensToBuySeedSale;
         require(seedSaledQuantity<= seedSaleQuantity);
         token.buyTokens(_buyer, tokensToBuySeedSale);
        
   }
   
   
   /*
    * Finalsale function with token value dynamically alocated
    */
   
     function finalSalebuy(uint256 _value,address _buyer) private {
         require(tokenFinalValueInUSD != 0);
      tokensToBuyFinalSale = (_value*ethPrice)/(tokenFinalValueInUSD*1e18);
       finalSaledQuantity+=tokensToBuyFinalSale;
         require(finalSaledQuantity<= finalSaleQuantity);
         token.buyTokens(_buyer, tokensToBuyFinalSale);
        
   }
   
   
   // transfer the ether to owner after the ico completes
   
    function extractEther() public whenIcoCompleted onlyOwner {
        owner.transfer(address(this).balance);
   }
  
}