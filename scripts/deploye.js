const { ethers } = require('hardhat');
/** This is a function used to deploy contract */
const hre = require('hardhat');

async function main() {
  const Locker = await hre.ethers.getContractFactory('Locker');
  const _Locker = await Locker.deploy();
  console.log(
    'Locker deployed to:',
    _Locker.address,
  );
}

main().
  then(() => process.exit(0)).
  catch((error) => {
    console.error(error);
    process.exit(1);
  });