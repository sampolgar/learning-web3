// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {

    uint256 public minimumUsd = 1* 1e18;


    function fund() public payable{
        require(convertEthToUsd(msg.value) >= minimumUsd, "sorry, not enough");
    }

    //converted is in usd
    function convertEthToUsd(uint256 ethAmount) public view returns(uint256){
        uint256 ethPrice = getEthPrice();
        uint256 converted = (ethPrice * ethAmount) / 1e18;
        return converted;
    }

    //eth price is in Wei 1624,2249276800,00000000
    function getEthPrice() public view returns(uint256){
        AggregatorV3Interface chainlinkPrice = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        (,int256 answer, , , ) = chainlinkPrice.latestRoundData();
        return uint256(answer * 1e10);
    }
}














// Get funds from users
// Withdraw funds
// Set a minimum value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {
    // uint256 public minimumUsd = 50;
    // remember 50 usd need to be in Wei form i.e. 50 * 1e18;
    uint256 public minimumUsd = 1 * 1e18;

    function fund() public payable{
        require(getConversionRate(msg.value) >= minimumUsd, "didn't send enough!");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }

    function getPrice() public view returns(uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        (,int256 answer,,,) = priceFeed.latestRoundData();
        return uint256(answer * 1e10);
    }

    function getConversionRate(uint256 ethAmount) public view returns (uint256){
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18; //always multiply before dividing in Solidity
        return ethAmountInUsd;
    }

}




// // Get funds from users
// // Withdraw funds
// // Set a minimum value in USD

// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.0;

// import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {
    // uint256 public minimumUsd = 50;
    // remember 50 usd need to be in Wei form i.e. 50 * 1e18;
    uint256 public minimumUsd = 1 * 1e18;

    //create an array with the funders addresses
    address[] public funders;

    //create a map between the address and amount given
    mapping(address => uint256) public addressToAmountFunded;

    function fund() public payable{
        require(getConversionRate(msg.value) >= minimumUsd, "didn't send enough!");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }

    function getPrice() public view returns(uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        (,int256 answer,,,) = priceFeed.latestRoundData();
        return uint256(answer * 1e10);
    }

    function getConversionRate(uint256 ethAmount) public view returns (uint256){
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18; //always multiply before dividing in Solidity
        return ethAmountInUsd;
    }

    // function withdraw() {

    // }

}