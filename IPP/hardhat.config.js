   /**
   * @type import('hardhat/config').HardhatUserConfig
   */

   require("@nomiclabs/hardhat-ethers");

   module.exports = {
      solidity: "0.8.7",
      defaultNetwork: "besu",
      networks: {
         localhost: {
            url: "http://127.0.0.1:8545",
            accounts: [`c1e1381764d5a5db7ef6b3246f7d931e46b4498e8b904a9d8714594323914d23`]
         },
         remote: {
            url: "http://127.0.0.1:8545",
            accounts: [`c1e1381764d5a5db7ef6b3246f7d931e46b4498e8b904a9d8714594323914d23`]
          },
         hardhat: {
         },
         gorelieth: {
            url: "https://eth-goerli.g.alchemy.com/v2/Lc66VMNnlvTn6wUg-cFyBW75udW56T4c",
            accounts: [`c1e1381764d5a5db7ef6b3246f7d931e46b4498e8b904a9d8714594323914d23`]
         },
         besu: {
            url: "http://127.0.0.1:8545",
            accounts: ["c87509a1c067bbde78beb793e6fa76530b6382a4c0241e5e4a9ec0a0f44dc0d3",
            "8f2a55949038a9610f50fb23b5883af3b4ecb3c3bb792cbcefbd1542c692be63",
            "ae6ae8e5ccbfb04590405997ee2d52d2b330726137b875053c36d94e974d162f"],
         },
      },
   }
