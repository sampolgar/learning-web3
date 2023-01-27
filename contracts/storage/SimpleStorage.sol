// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStorage {

    uint256 public favoriteNumber;
    People public person = People({
        favoriteNumber: 2,
        name: "Sam"
    });

    struct People {
        uint256 favoriteNumber;
        string name;
    }

    mapping(string => uint256) public nameToFavoriteNumber;

    People[] public people;

    function store(uint256 _favoriteNumber) public virtual{
        favoriteNumber = _favoriteNumber;
        retrieve();
    }

    function retrieve() public view returns(uint256){
        return favoriteNumber; 
    }

    function addPerson(string calldata _name, uint256 _favoriteNumber) public {
        People memory newPerson = People(_favoriteNumber, _name );
        people.push(newPerson);
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}