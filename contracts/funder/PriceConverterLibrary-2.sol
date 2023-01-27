// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

//libraries can't have state variables & can't send eth
library PriceConverter {


// get the price of the layer 1 we're on
    // function is public so we can call them and test them
    
    // old = function getPrice() public view returns(uint256){
    // when moved to a library, change public view to internal view
    function getPrice() internal view returns(uint256){

        
        //We need to get the price from the Oracle
        //To interact with other contracts, we need the Address + ABI
        //Address (easy) => 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
        //ABI => import the library from another file e.g. import "./" or import from github import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
        // note on ABI -> it's a list of functions you can call but not their implementation. e.g. function library 
        
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        
        // priceFeed.latestRoundData(); because the latest round data returns ( uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound) we need to declare which we want
        // If we wanted all variables, it would look like
        // (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound) = priceFeed.latestRoundData();
        //but we only need price, so we can destructure the response
        (,int256 answer,,,) = priceFeed.latestRoundData();
        //we use int256 because an int can be negative
        //answer will have 8 decimal places, you can check with the priceFeed.decimals() method
        //because our public payable function has 18 decimal places we need to 
        // return price * 1e10; -- but this isn't type cast to uint256 so...
        
        return uint256(answer * 1e10);
    }

    
    // we need to get conversion rate because the public payable contract is in ETH and I want to be paid a minimum of 1USD
    function getConversionRate(uint256 ethAmount) internal view returns (uint256){
        //first get the eth price
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18; //always multiply before dividing in Solidity
        return ethAmountInUsd;
    }

}