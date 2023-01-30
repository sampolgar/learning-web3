// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStorage {
  //receive a favorite number and store it
  //create a person struct
  //create an array of persons
  //each time a number is received, add it to the person array

  uint256 public favNum;

  struct Person {
    string name;
    uint256 favNum;
  }

  Person[] public people;

  function store(uint256 _favNum) public {
    favNum = _favNum;
  }

  function retrieve() public view returns (uint256) {
    return favNum;
  }

  function add(string memory _name, uint256 _favNum) public {
    people.push(Person(_name, _favNum));
  }
}
