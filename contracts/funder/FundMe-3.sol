// Get funds from users
// Withdraw funds
// Set a minimum value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./PriceConverterLibrary-2.sol";

error NotOwner();

contract FundMe {
    using PriceConverter for uint256;

    // uint256 public MINIMUM_USD = 1 * 1e18;    changes to =>
    uint256 public constant MINIMUM_USD = 1 * 1e18;
    // constant is read only and reduces gas fee

    //create an array with the funders addresses
    address[] public funders;

    //create a map between the address and amount given
    mapping(address => uint256) public addressToAmountFunded;

    // address public owner;  changes into ==>
    address public immutable i_owner;`

    constructor() {
        i_owner = msg.sender;
    }

    //make it public and payable. payable means it can receive money
    // use msg.value to get the value of whatever they're paying
    // using require(msg.value > 1e18) means you specify a minimum amount of Ether receive
    // 1e18 because https://eth-converter.com/ 1 eth = 1000000000000000000 gwei
    // change require(msg.value > 1e18) to require(msg.value > 1e18, "Didn't send enough") to catch error

    function fund() public payable {
        // require(msg.value > 1e18, "Not enough");
        // has 18 decimal places
        // require(getConversionRate(msg.value) >= MINIMUM_USD, "didn't send enough!");
        //msg.sender is the senders address
        require(
            msg.value.getConversionRate() >= MINIMUM_USD,
            "didn't send enough"
        );
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }

    function withdraw() public onlyOwner {
        //loop through funders array
        for (
            uint256 funderIndex = 0;
            funderIndex < funders.length;
            funderIndex++
        ) {
            // funders[funderIndex] returns the address
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);
        (bool callSuccess, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        require(callSuccess, "call failed");
    }

    modifier onlyOwner() {
        // require(msg.sender == i_owner, "sender isn't owner");
        // _;

        if (msg.sender != i_owner) {
            revert NotOwner();
        }
        _;
    }

    //add a receive and fallback
    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }
}
