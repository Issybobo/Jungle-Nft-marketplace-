const { ethers } = require("hardhat");

async function main() {
  // Deploy the JungleNft contract
  const JungleNft = await ethers.getContractFactory("JungleNft");
  const jungleNft = await JungleNft.deploy();
  await jungleNft.deployed();

  console.log("JungleNft deployed to:", jungleNft.address);

  // Deploy the JungleNftMarketplace contract
  const JungleNftMarketplace = await ethers.getContractFactory("JungleNftMarketplace");
  const jungleNftMarketplace = await JungleNftMarketplace.deploy();
  await jungleNftMarketplace.deployed();

  console.log("JungleNftMarketplace deployed to:", jungleNftMarketplace.address);

  // Deploy the Pepecoin contract
  const Pepecoin = await ethers.getContractFactory("Pepecoin");
  const pepecoin = await Pepecoin.deploy();
  await pepecoin.deployed();

  console.log("Pepecoin deployed to:", pepecoin.address );
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
