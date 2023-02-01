//imports
import { ethers, run, network } from "hardhat"

//async main
async function main() {
    const SimpleStorageFactory = await ethers.getContractFactory(
        "SimpleStorage"
    )

    const simpleStorage = await SimpleStorageFactory.deploy()
    
    await simpleStorage.deployed()
    
    console.log(`deployed at ${simpleStorage.address}`)

    if (network.config.chainId == 5) {
        console.log("verifying on etherscan")
        await simpleStorage.deployTransaction.wait(6)
        await verify(simpleStorage.address, [])
        console.log("verified")
    } else {
        console.log("skipping verification")
    }

    const currentValue = await simpleStorage.retrieve()
    console.log(`current value: ${currentValue}`)

    const transactionResponse = await simpleStorage.store(5)
    await transactionResponse.wait(1)
    const updatedValue = await simpleStorage.retrieve()
    console.log(`updated value: ${updatedValue}`)
}

async function verify(contactAddress: string, args: any[]) {
    try {
        await run("verify:verify", {
            address: contactAddress,
            constructorArguments: args,
        })
    } catch (e: any) {
        if (e.message.includes("Contract source code already verified")) {
            console.log("Contract source code already verified")
        } else {
            console.log(e)
        }
    }
}

//main

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error)
        process.exit(1)
    })
