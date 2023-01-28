// https://docs.openzeppelin.com/learn/deploying-and-interacting#setup
//create a hardhat deployment script to deploy the SimpleStorage contract & 1. verify it on Etherscan 2. interact with it and log value
//Deploy the contract to hardhat network to view transactions on the console chain
//Deploy the contract to the Goerli testnet and verify it on Etherscan
//create tests for the contract

const { ethers, run, network } = require("hardhat")

const main = async () => {
    const SimpleStorageFactory = await ethers.getContractFactory(
        "SimpleStorage"
    )
    const simpleStorage = await SimpleStorageFactory.deployContract()   //create contract object with deployed contract
    await simpleStorage.deployContract()
    console.log(`deployed at ${simpleStorage.address}`)
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error)
        process.exit(1)
    })
