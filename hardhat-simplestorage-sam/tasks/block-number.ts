// const { task } = require("hardhat/config")
// require("@nomicfoundation/hardhat-toolbox")

import { task } from "hardhat/config"
import "@nomicfoundation/hardhat-toolbox"

// task("balance", "prints account balance").setAction(async () => {})

export default task("block-number", "prints block number").setAction(
  async (taskArgs, hre) => {
    const blockNumber = await hre.ethers.provider.getBlockNumber()
    console.log(`current block number: ${blockNumber}`)
  }
)
