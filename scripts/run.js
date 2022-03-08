const main = async () => {
  const waveContractFactory = await hre.ethers.getContractFactory("WavePortal"); // Compiles the contract and generates necessary files under the artifacts directory
  
  const [deployer] = await hre.ethers.getSigners(); //getting the account which is deploying the contract
  const accountBalance = await deployer.getBalance(); // getting the balance of the account which is deploying the contract
  console.log("The Deployer's address -> ", deployer.address);
  console.log("The Balance of Deployer's account is -> ", hre.ethers.utils.formatEther(accountBalance));

  // using this like, hardhat creates a local Ethereum network for us, but just for the contract.
  // After the script complets, it destroyes the local Ethereum network.
  // everytime we run this file, it will be on a fresh blockchain
  const waveContract = await waveContractFactory.deploy({
    value: hre.ethers.utils.parseEther("5"), // this will remove the 0.1 eth from my wallet and use it to fund the contract.
  });

  await waveContract.deployed();
  console.log("Contract addy:", waveContract.address); // address of the deployed contract

  let contractBalance = await hre.ethers.provider.getBalance(
    waveContract.address
  );
  console.log(
    "Contract balance:",
    hre.ethers.utils.formatEther(contractBalance)
  );

  // checking the wallet balance after funding the contract.
  console.log("The Updated Balance of Deployer's account is -> ", hre.ethers.utils.formatEther(await deployer.getBalance()));

  /*
   * Let's try two waves now
   */
  const waveTxn = await waveContract.wave("This is wave #1");
  await waveTxn.wait();

  const waveTxn2 = await waveContract.wave("This is wave #2");
  await waveTxn2.wait();

  contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
  console.log(
    "Contract balance:",
    hre.ethers.utils.formatEther(contractBalance)
  );

  let allWaves = await waveContract.getAllWaves();
  console.log(allWaves);
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();