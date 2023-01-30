import { expect, assert } from 'chai';
import { ethers } from 'hardhat';
import { SimpleStorage, SimpleStorage__factory } from '../typechain-types';

describe('SimpleStorage', function () {
  //initialize variables
  let simpleStorageFactory: SimpleStorage__factory,
    simpleStorage: SimpleStorage;
  //create contract
  beforeEach(async function () {
    simpleStorageFactory = (await ethers.getContractFactory(
      'SimpleStorage'
    )) as SimpleStorage__factory;
    simpleStorage = await simpleStorageFactory.deploy();
  });

  //run tests
  it('should first return 0', async function () {
    const givenValue = await simpleStorage.retrieve();
    const expectedValue = 0;
    expect(givenValue).to.equal(expectedValue);
  });

  it('should first return the add number', async function () {
    await simpleStorage.add(7);
    const expectedValue = 7;
    const retrievedValue = await simpleStorage.retrieve();
    expect(retrievedValue).to.equal(expectedValue);
  });

  it('should add a person and the array should be 1 bigger', async function () {
    const initialSize = await simpleStorage.getArrayLength();
    await simpleStorage.addPerson(8, 'sam');
    const currentSize = await simpleStorage.getArrayLength();
    expect(initialSize).to.equal(currentSize.sub(1));
  });
});
