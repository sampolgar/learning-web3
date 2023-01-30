// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
import hre from "hardhat"

async function main() {
  const SimpleStorageFactory = await hre.ethers.getContractFactory(
    "SimpleStorage"
  )
  const simpleStorage = await SimpleStorageFactory.deploy()
  await simpleStorage.deployed()

  // await simpleStorage.deployTransaction.wait(6)
  console.log(`deployed contract at ${simpleStorage.address}`)

  //wait for block confirmation
  if (hre.network.config.chainId === 5 && process.env.ETHERSCAN_API_KEY) {
    console.log("Waiting for block confirmations...")
    await simpleStorage.deployTransaction.wait(6)
    await verify(simpleStorage.address, [])
  }

  //quick contract test
  const transactionResponse = await simpleStorage.store(7)
  await transactionResponse.wait(1)
  const updatedVal = await simpleStorage.retrieve()
  console.log(`updated value  ${updatedVal}`)
}

const verify = async (contractAddress: string, args: any[]) => {
  console.log("Verifying contract...")
  try {
    await hre.run("verify:verify", {
      address: contractAddress,
      constructorArguments: args,
    })
  } catch (e: any) {
    if (e.message.toLowerCase().includes("already verified")) {
      console.log("Already Verified!")
    } else {
      console.log(e)
    }
  }
}

main().catch((error) => {
  console.error(error)
  process.exitCode = 1
})
