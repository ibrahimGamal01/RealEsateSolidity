// src/utils/web3.js

import Web3 from 'web3';

let web3;

if (window.ethereum) {
  web3 = new Web3(window.ethereum);
  try {
    window.ethereum.enable();
  } catch (error) {
    console.error('User denied account access:', error);
  }
} else if (window.web3) {
  web3 = new Web3(window.web3.currentProvider);
} else {
  const provider = new Web3.providers.HttpProvider('http://localhost:7545');
  web3 = new Web3(provider);
}

export default web3;
