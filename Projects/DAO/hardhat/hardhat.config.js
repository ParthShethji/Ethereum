require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.18",
  networks: {
    sepolia: {
      url: process.env.RPC_URL,
      accounts: [process.env.PRIVATE_KEY],
    },
  },
  etherscan: {
    apiKey: {
      sepolia: process.env.ETHERSCAN_API_KEY,
    }
  },
};
// CryptoDevsNFT deployed to: 0x16b57719D2fcD1d5b883a43554B6b5F1c9b359D1
// FakeNFTMarketplace deployed to: 0xe938F2927d5241dCDf7a0937820F07F186bD8f3E
// CryptoDevsDAO deployed to: 0x95d044df2F65F154bCc5102abECDfd509B43B94B