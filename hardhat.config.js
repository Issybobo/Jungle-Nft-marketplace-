require("@nomicfoundation/hardhat-toolbox");
require('dotenv').config();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: '0.8.19',
  networks: {
    sepolia: {
      url: 'https://sepolia.infura.io/v3/f309986696d64581b1119fa1b6f1ac0c',
      accounts: ['50ad9c8cda37f748f54d26f4a7f18b69c3b7c01821dac0128c598e891f88b08a'],
    },
  },
};
