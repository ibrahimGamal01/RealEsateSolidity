// src/utils/contract.js

import RealEstateEscrow from './../contracts/RealEstateEscrow.json';
import web3 from './web3';

const contractAddress = '0x28ee5f67e69b9f44f801857f0335d248b874a5a7'; // Replace with your deployed contract address

const contract = new web3.eth.Contract(RealEstateEscrow.abi, contractAddress);

export default contract;
