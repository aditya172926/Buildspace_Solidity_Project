// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract WavePortal {

    uint256 totalWaves;

    constructor() {
        console.log("Yo yo, I am a contract and I am smart. This is made by Aditya Singh");
    }

    function wave() public { // Think of this like a public API endpoint :)
        totalWaves+=1;
        console.log("%s has waved!", msg.sender); // This is the wallet address of the person who called the function. It's like built-in authentication. We know exactly who called the function because in order to even call a smart contract function, you need to be connected with a valid wallet!
    }
    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }
}