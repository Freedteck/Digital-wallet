// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract DigitalWallet {

    // State variables
    address private owner;
    
    // Struct to store transaction details
    struct History {
        address sender;
        uint256 amount;
        uint256 time;
        string tx_type;
    }
    
    // Array to store all transaction histories
    History[] public allTransactions;

    constructor() {
        owner = msg.sender;
    }

    // Function to send money
    function send_money(address to, uint256 amount) public {
        require(msg.sender == owner, "You are not the wallet owner");
        uint256 balance = address(this).balance;
        require(amount <= balance, "Insufficient amount");
        payable(to).transfer(amount);
        logTransaction(msg.sender, amount, "Transfer");
    }

    // Function to receive money
    function receive_money() public payable {
        require(msg.value > 0);
        logTransaction(msg.sender, msg.value, "Receive");
    }

    // Function to withdraw money
    function withdraw(uint256 amount) public {
        require(msg.sender == owner, "You are not the wallet owner");
        uint256 balance = address(this).balance;
        require(amount <= balance, "Insufficient amount");
        payable(owner).transfer(amount);
        logTransaction(msg.sender, amount, "Withdraw");
    }

    // Function to get the balance of the contract
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function logTransaction(address sender, uint256 amount, string memory tx_type) private {
        History memory newHistory = History({
            sender: sender,
            amount: amount,
            time: block.timestamp,
            tx_type: tx_type
        });
        allTransactions.push(newHistory);
    }

    // Function to get all transaction history
    function getTxHistory() public view returns (History[] memory) {
        return allTransactions;
    }
}
