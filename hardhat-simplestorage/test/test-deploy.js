const { ethers } = require("hardhat")
const { expect, assert, Assertion } = require("chai")

describe("SimpleStorage", function () {
    let SimpleStorageFactory, simpleStorage
    beforeEach(async function () {
        simpleStorageFactory = await ethers.getContractFactory("SimpleStorage")
        simpleStorage = await simpleStorageFactory.deploy()
    })

    it("should start with a favorite number 0", async function () {
        const currentValue = await simpleStorage.retrieve()
        console.log(`current value is ${currentValue}`)
        const expectedValue = "0"
        assert.equal(currentValue.toString(), expectedValue)
    })

    it("should update when we store a number", async function () {
        const valUpdated = 5
        const res = await simpleStorage.store(valUpdated)
        await res.wait(1)

        const valReturned = await simpleStorage.retrieve()
        console.log(` -------- ${valReturned}`)
        assert.equal(valUpdated, valReturned)
    })

    it("should add a new person to the people array and look up a favourite number based on a person name", async function () {
        const expectedName = "sam"
        const expectedFavNum = "7"
        //person at end of array should be sam
        const transactionResponse = await simpleStorage.addPerson(
            expectedName,
            expectedFavNum
        )
        await transactionResponse.wait(1)

        const { favoriteNumber, name } = await simpleStorage.people(0)

        assert.equal(name, expectedName)
        assert.equal(favoriteNumber, expectedFavNum)
    })
})
