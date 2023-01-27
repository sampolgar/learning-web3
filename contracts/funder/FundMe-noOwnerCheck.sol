// Get funds from users
// Withdraw funds
// Set a minimum value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./PriceConverter.sol";

contract FundMe {
    
    using PriceConverter for uint256;
    //I think this means any uint256 can use the methods in PriceConverter
    
    // uint256 public minimumUsd = 50;
    // remember 50 usd need to be in Wei form i.e. 50 * 1e18;
    uint256 public minimumUsd = 1 * 1e18;

    //create an array with the funders addresses
    address[] public funders;

    //create a map between the address and amount given
    mapping(address => uint256) public addressToAmountFunded;


    //make it public and payable. payable means it can receive money
    // use msg.value to get the value of whatever they're paying
    // using require(msg.value > 1e18) means you specify a minimum amount of Ether receive
    // 1e18 because https://eth-converter.com/ 1 eth = 1000000000000000000 gwei
    // change require(msg.value > 1e18) to require(msg.value > 1e18, "Didn't send enough") to catch error

    function fund() public payable{
        // require(msg.value > 1e18, "Not enough");
        // has 18 decimal places
        // require(getConversionRate(msg.value) >= minimumUsd, "didn't send enough!");
        //msg.sender is the senders address
        require(msg.value.getConversionRate() >= minimumUsd, "didn't send enough");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }

    function withdraw() public {
        //loop through funders array
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
            // funders[funderIndex] returns the address
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        //reset array
        //create a new funders array of addresses with 0 objects
        funders = new address[](0);
        //if you need a new array with 1 object, new address[](1)


        //withdraw funds
        //3 ways - transfer, send, call
        // details https://solidity-by-example.org/sending-ether/


        //msg.sender = address
        //payable(msg.sender) = payable address
        //transfer (throws error)
        // payable(msg.sender).transfer(address(this).balance);

        // // send (returns bool)
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "send failed");
        
        // call
        //payable(msg.sender).call{value: address(this).balance}("");
        // this function returns 2 variables. Destructure them on the right
        //because we're calling any function we need bytes memory
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "call failed");
    }

}