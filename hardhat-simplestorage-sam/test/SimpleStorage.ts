import { expect } from "chai"
import { ethers } from "hardhat"
import "@typechain/hardhat"
import { SimpleStorage, SimpleStorage__factory } from "../typechain-types"
//where ever contract is, import typechain-types

describe("SimpleStorage", function () {
  // let simpleStorageFactory
  // let simpleStorage
  let simpleStorageFactory: SimpleStorage__factory, simpleStorage: SimpleStorage
  beforeEach(async function () {
    simpleStorageFactory = (await ethers.getContractFactory(
      "SimpleStorage"
    )) as SimpleStorage__factory
    simpleStorage = await simpleStorageFactory.deploy()
  })

  it("should start with a favnum = 0", async function () {
    const firstValue = await simpleStorage.retrieve()
    const expectedValue = 0
    expect(firstValue).to.equal(expectedValue)
  })

  it("should update the fav num to 7", async function () {
    await simpleStorage.store(7)
    const updatedNumber = await simpleStorage.retrieve()
    const expectedValue = 7
    expect(updatedNumber).to.equal(expectedValue)
  })
})
