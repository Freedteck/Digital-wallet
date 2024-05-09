// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract DigitalWallet {
    string public owner;
    string public receiver;
    uint256 public receiverBalance = 0;
    uint256 public balance;
    uint256 private ownerBalance = 0;

    constructor() {
        owner = "Mubarak Freed";
        balance = 1000000000;
        receiver = "Somebody";
    }

    function sendMoney(uint256 amount) public {
        balance -= amount;
        receiverBalance += amount;
    }

    function receiveMoney(uint256 amount) public {
        receiverBalance -= amount;
        balance +=amount;
    }

    function withdraw() public returns (uint256) {
        ownerBalance = balance + receiverBalance;
        receiverBalance = 0;
        ownerBalance = 0;
        return ownerBalance;
    }
}
