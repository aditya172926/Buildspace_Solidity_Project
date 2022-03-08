// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract WavePortal {

    uint256 totalWaves;

    // we will use this to help generate a random number
    uint256 private seed;
    event NewWave(address indexed from, uint256 timestamp, string message);

    struct Wave {
        address waver; // The address of the user who waved.
        string message; // The message the user agent.
        uint256 timestamp; // The timestamp when the user waved.
    }

    Wave[] waves;

    // I declare a variable waves that lets me store an array of structs.
    // This is what lets me hold all the waves anyone ever sends to me!

    // mapping
    mapping(address => uint256) public lastWavedAt;

    constructor() payable {
        console.log("Yo yo, I am a contract and I am smart. This is made by Aditya Singh");
        // setting the initial seed.
        seed = (block.timestamp + block.difficulty) % 100;
    }

    
    // You'll notice I changed the wave function a little here as well and
    // now it requires a string called _message. This is the message our user
    // sends us from the frontend!
    
    function wave(string memory _message) public { // Think of this like a public API endpoint :) 
        // we need to make sure the current timestamp is at least 15 minutes bigger than the last timestamp we stored
        require (
            lastWavedAt[msg.sender]+ 15 minutes < block.timestamp, "Wait 15m"
        );

        // update the current timestamp we have for the user.
        lastWavedAt[msg.sender] = block.timestamp;
        
        totalWaves+=1;
        console.log("%s waved w/ message %s", msg.sender, _message); // This is the wallet address of the person who called the function. It's like built-in authentication. We know exactly who called the function because in order to even call a smart contract function, you need to be connected with a valid wallet!

        // This is where I actually store the wave data in the array.
        waves.push(Wave(msg.sender, _message, block.timestamp));

        // generate a new seed for the next user that sends a wave.
        seed = (block.difficulty + block.timestamp + seed) % 100;
        console.log("Random # generated: %d", seed);
        
        // give a 50% chance that the user wins
        if (seed <= 50) {
            console.log("%s won!", msg.sender);
            uint256 prizeAmount = 0.0001 ether;
            require(
                prizeAmount <= address(this).balance,
                "Trying to withdraw more money than the contract has."
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from contract.");
        }

        // I added some fanciness here, Google it and try to figure out what it is!
        // Let me know what you learn in #general-chill-chat
        emit NewWave(msg.sender, block.timestamp, _message);

    }

    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }
}