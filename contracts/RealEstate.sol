//SPDX-License-Identifier: Unlicense
  // specifies the license for the code. Unlicense is a public domain dedication license, which means that the code is free for anyone to use without any restrictions.
pragma solidity ^0.8.0;
// version of Solidity used in the code. The caret (^) symbol indicates that the code is compiled with a compatible version of Solidity.

import "@openzeppelin/contracts/utils/Counters.sol";
//import the Counters contract from the OpenZeppelin library, which provides a way to manage and increment counters.

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
// ERC721: the base implementation of the ERC721 standard for creating non-fungible tokens (NFTs).

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
//ERC721URIStorage: extends the ERC721 contract and adds support for storing and managing token URIs.


contract RealEstate is ERC721URIStorage {
// Define a contract named RealEstate that inherits from the ERC721URIStorage contract.

    using Counters for Counters.Counter;
    // Use the Counters.sol contract to manage the token IDs.

    Counters.Counter private _tokenIds;
    // Declare a private counter variable named _tokenIds to store the token IDs.

    constructor() ERC721("Real Estate", "REAL") {}
    // ERC721 there constructor takes a name and a symbol as arguments.
    // Create a constructor function (excuted only once when the contract is deployed) that initializes the contract with the name "Real Estate" and the symbol "REAL".

    function mint(string memory tokenURI) public returns (uint256) {
    // Define the mint that allows users to mint new tokens

        _tokenIds.increment();
        // incrememnt token id by 1

        uint256 newItemId = _tokenIds.current();
        // get the current token id

        _mint(msg.sender, newItemId);
        // mint the token and assign it to the sender

        _setTokenURI(newItemId, tokenURI);
        // set the metadata URI for the newly minted token.

        return newItemId;
        // Item created ^_~ 
    }

    function totalSupply() public view returns (uint256) {
    //public view function that returns the total number of tokens minted.
        return _tokenIds.current();
        //retrieves the current value of the _tokenIds counter and returns it.
    }
}