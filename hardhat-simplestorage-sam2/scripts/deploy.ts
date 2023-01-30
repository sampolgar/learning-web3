import { ethers, run, network } from 'hardhat';
import '@nomiclabs/hardhat-etherscan';

async function main() {
  //deploy
  const SimpleStorageFactory = await ethers.getContractFactory('SimpleStorage');
  const simpleStorage = await SimpleStorageFactory.deploy();
  await simpleStorage.deployed();
  console.log(`simple storage contract deployed ${simpleStorage.address}`);

  //if the network is goerli, verify the transaction on etherscan
  if (network.config.chainId == 5) {
    console.log('verifying');
    //verify on etherscan
    await simpleStorage.deployTransaction.wait(6);
    await verify(simpleStorage.address, []);
    console.log('verified');
  } else {
    console.log('unverified');
  }

  //interact. add, retrieve, addPerson
  const transactionResponse = await simpleStorage.add(7);
  console.log(`transactionResponse is ${transactionResponse}`);

  const retrieve = await simpleStorage.retrieve();
  console.log(`retriever ${JSON.stringify(retrieve)}`);
}

const verify = async (contractAddress: string, args: any[]) => {
  try {
    await run('verify: verify', {
      address: contractAddress,
      constructorArguments: args,
    });
  } catch (e: any) {
    if (e.message.includes('Contract source code already verified')) {
      console.log('Contract source code already verified');
    } else {
      console.log(e);
    }
  }
};

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
