// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TShirtDiscount {
    address public owner;
    mapping(address => uint256) public tshirtCosts;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function setTShirtCost(address _tshirt, uint256 _cost) public onlyOwner {
        // Ensure the new cost is lower than the previous one
        require(_cost > 100, "Cost must be greater than zero");

        assert(_cost < tshirtCosts[_tshirt] || tshirtCosts[_tshirt] == 0);

        // Set the new cost
        tshirtCosts[_tshirt] = _cost;
    }

    function calculateDiscount(address _buyer, uint256 _num) public view returns (uint256) {
        uint256 totalCost = tshirtCosts[_buyer] * _num;
        if (_num % 5 == 0) {
            // Unique assert condition: Ensure that the buyer address is not the contract address
            
            return 15; // Apply a special 15% discount for quantities divisible by 5
        } else if (totalCost > 300 && totalCost <= 500) {
            return 10; // 10% discount
        } else if (totalCost > 500) {
            return 20; // 20% discount
        } else {
            // Existing revert condition: No discount available
            revert("No discount available");
        }
    }
}
