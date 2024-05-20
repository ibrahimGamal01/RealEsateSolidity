// truffle-config.js
module.exports = {
    networks: {
      development: {
        host: "127.0.0.1",
        port: 7545,
        network_id: "*", // Match any network id
      },
      // Add other network configurations as needed
    },
    compilers: {
      solc: {
        version: "0.8.1", // Use the correct Solidity compiler version
      },
    },
  };
  