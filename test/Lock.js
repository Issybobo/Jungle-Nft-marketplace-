const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("JungleNftMarketplace Lock", function () {
  it("Should lock the contract after listing an NFT", async function () {
    // Deploy the JungleNftMarketplace contract
    const JungleNftMarketplace = await ethers.getContractFactory("JungleNftMarketplace");
    const jungleNftMarketplace = await JungleNftMarketplace.deploy();
    await jungleNftMarketplace.deployed();

    // Get the address of the deployer (the account that deployed the contract)
    const [deployer] = await ethers.getSigners();

    // Initially, the contract should not be locked
    expect(await jungleNftMarketplace.isLocked()).to.be.false;

    // List an NFT for sale
    const NFTContractAddress = "0x..."; // Replace with the actual ERC721 contract address
    const tokenId = 123; // Replace with the token ID of the NFT to be listed
    const price = ethers.utils.parseEther("1"); // Replace with the desired price in ether
    await jungleNftMarketplace.listNFT(NFTContractAddress, tokenId, price);

    // Now, the contract should be locked
    expect(await jungleNftMarketplace.isLocked(tokenId)).to.be.true;

    // Ensure that only the deployer can unlock the contract
    await expect(jungleNftMarketplace.connect(deployer).unlock(tokenId)).to.not.be.reverted;
    await expect(jungleNftMarketplace.connect(deployer).unlock(tokenId)).to.be.revertedWith("Contract is not locked");

    // Verify that the contract is unlocked after calling the unlock function
    expect(await jungleNftMarketplace.isLocked(tokenId)).to.be.false;
  });
});
