import { ethers } from 'ethers';
import * as fs from 'fs-extra';
import 'dotenv/config';

async function main() {
  const wallet = new ethers.Wallet(process.env.PRIVATE_KEY!);
  const encryptedJsonKey = await wallet.encrypt(
    process.env.PASSWORD!,
    process.env.PRIVATE_KEY!
  );
  fs.writeFileSync('./encryptedKey.json', encryptedJsonKey);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
