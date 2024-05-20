
# Homyz Real Estate Project

This project is a Real Estate Escrow system built using Solidity for smart contracts and React for the frontend. It uses Truffle for contract compilation and deployment, and Ganache for a local blockchain environment.

## Project Structure

- ``contracts/``
- ``img/``
- ``metadata/``
- ``scripts/``
- ``test/``
- ``package.json``

## Setup

1. Initialize Truffle in the project directory:

```sh
truffle init
```

2. Create your smart contracts in the ``contracts/`` directory. An example contract ``RealEstateEscrow.sol`` is already provided.

3. Compile the contracts:

```sh
truffle compile
```

4. Create a new React app in the project directory:

```sh
npx create-react-app .
```

5. Install the necessary dependencies:

```sh
npm install web3@latest @truffle/contract @metamask/detect-provider
```

## Running the Project

1. Start Ganache CLI to create a local Ethereum blockchain:

```sh
ganache-cli
```

2. Deploy the contracts to the Ganache blockchain:

```sh
truffle migrate --network development
```

3. Start the React app:

```sh
npm start
```

Now, you should be able to interact with the contracts through the React app.


## Deployment

To build the React app for production, use the following command:

```sh
npm run build
```

This will create a `build/` directory with the production-ready app.

