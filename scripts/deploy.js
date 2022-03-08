const main = async () => {
    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal"); // Compiles the contract and generates necessary files under the artifacts directory
    
    // using this like, hardhat creates a local Ethereum network for us, but just for the contract.
    // After the script complets, it destroyes the local Ethereum network.
    // everytime we run this file, it will be on a fresh blockchain
    const waveContract = await waveContractFactory.deploy({
      value: hre.ethers.utils.parseEther("0.001"), // this will remove the 0.001 eth from my wallet and use it to fund the contract.
    });
  
    await waveContract.deployed();
  
    console.log("WavePortal address: ", waveContract.address); // address of the deployed contract. You can check for this on etherscan

    let contractBalance = await hre.ethers.provider.getBalance(
      waveContract.address
    );
    console.log(
      "Contract balance:",
      hre.ethers.utils.formatEther(contractBalance)
    );
    
  };
  
  const runMain = async () => {
    try {
      await main();
      process.exit(0);
    } catch (error) {
      console.error(error);
      process.exit(1);
    }
  };
  
  runMain();