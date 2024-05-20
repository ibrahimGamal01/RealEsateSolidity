import React, { useState } from 'react';
import { Button, TextField, Container, Typography, Box } from '@mui/material';
import contract from '../../Helpers/contract';
import web3 from '../../Helpers/web3';

function AddListing() {
  const [price, setPrice] = useState('');
  const [tokenId, setTokenId] = useState('');
  const [mintTokenId, setMintTokenId] = useState('');
  const [mintAddress, setMintAddress] = useState('');

  const handleSubmit = async (event) => {
    event.preventDefault();
    const managerAddress = await contract.methods.manager().call();
    console.log('hi', managerAddress)
    const accounts = await web3.eth.getAccounts();
    const account = accounts[0];

    try {
      const owner = await contract.methods.ownerOf(tokenId).call();
      if (owner.toLowerCase() !== account.toLowerCase()) {
        alert('You do not own this token.');
        return;
      }

      await contract.methods.listProperty(tokenId, web3.utils.toWei(price, 'ether')).send({ from: '0x881316f82F96Bad0FdbE57d82718b5ddbC7486E7' });
      alert('Listing added successfully!');
    } catch (error) {
      if (error.message.includes('invalid token ID')) {
        alert('Invalid token ID. Please ensure the token exists and you are the owner.');
      } else {
        console.error('Error adding listing:', error);
        alert('Error adding listing. Check console for details.');
      }
    }
  };

  const handleMint = async () => {
    const accounts = await web3.eth.getAccounts();
    const account = accounts[0];

    try {
      await contract.methods.mint(mintAddress, mintTokenId).send({ from: account });
      alert(`Token ${mintTokenId} minted successfully to ${mintAddress}`);
    } catch (error) {
      console.error('Error minting token:', error);
      alert('Error minting token. Check console for details.');
    }
  };

  return (
    <Container maxWidth="sm">
      <Box sx={{ mt: 5 }}>
        <Typography variant="h4" component="h1" gutterBottom>
          Add Real Estate Listing
        </Typography>
        <form onSubmit={handleSubmit}>
          <TextField
            label="Token ID"
            variant="outlined"
            fullWidth
            margin="normal"
            value={tokenId}
            onChange={(e) => setTokenId(e.target.value)}
            required
          />
          <TextField
            label="Price (in ETH)"
            variant="outlined"
            fullWidth
            margin="normal"
            value={price}
            onChange={(e) => setPrice(e.target.value)}
            required
          />
          <Button type="submit" variant="contained" color="primary" fullWidth>
            Add Listing
          </Button>
        </form>
        <Box sx={{ mt: 5 }}>
          <Typography variant="h5" component="h2" gutterBottom>
            Mint New Token
          </Typography>
          <TextField
            label="Token ID to Mint"
            variant="outlined"
            fullWidth
            margin="normal"
            value={mintTokenId}
            onChange={(e) => setMintTokenId(e.target.value)}
            required
          />
          <TextField
            label="Address to Mint To"
            variant="outlined"
            fullWidth
            margin="normal"
            value={mintAddress}
            onChange={(e) => setMintAddress(e.target.value)}
            required
          />
          <Button variant="contained" color="secondary" fullWidth onClick={handleMint}>
            Mint Token
          </Button>
        </Box>
      </Box>
    </Container>
  );
}

export default AddListing;
