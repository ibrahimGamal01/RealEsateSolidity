// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract RealEstateEscrow is ERC721 {
    // State variables
    uint public totalSupply; // Total number of minted tokens
    address public manager; // Address of the manager who can perform administrative actions

    // Struct to store listing information for each token
    struct Listing {
        uint price; // Listing price of the property
        bool isListed; // Flag indicating if the property is listed for sale
        address buyer; // Address of the buyer who bought the property
        bool inspectionPassed; // Flag indicating if the property has passed inspection
    }


    // Mapping to store listings for each token ID
    mapping(uint => Listing) public listings;

    // Constructor to initialize the contract with a name and symbol
    constructor() ERC721("Real Estate", "REAL") {
        manager = msg.sender; // Set the manager as the contract deployer
    }

    // Modifier to restrict access to only the manager
    modifier onlyManager() {
        require(msg.sender == manager, "Only manager can perform this action");
        _;
    }

    // Function to mint new NFTs (only accessible by the manager)
    function mint(address to, uint tokenId) external onlyManager {
        _mint(to, tokenId); // Mint a new NFT and assign it to the specified address
        totalSupply++; // Increment the total supply of tokens
    }

    // Function to list a property for sale
    function listProperty(uint tokenId, uint price) external {
        require(ownerOf(tokenId) == msg.sender, "You are not the owner of this property");
        listings[tokenId] = Listing(price, true, address(0), false); // Create a new listing
    }

    // Function to buy a property listed for sale
    function buyProperty(uint tokenId) external payable {
        Listing storage listing = listings[tokenId]; // Get the listing for the token
        require(listing.isListed, "Property is not listed for sale");
        require(msg.value >= listing.price, "Insufficient funds sent");

        listing.isListed = false; // Mark the property as no longer listed
        listing.buyer = msg.sender; // Set the buyer of the property

        _transfer(ownerOf(tokenId), msg.sender, tokenId); // Transfer ownership of the token
        payable(ownerOf(tokenId)).transfer(msg.value); // Transfer funds to the seller
    }

    // Function to set the inspection status of a property (only accessible by the manager)
    function setInspectionStatus(uint tokenId, bool passed) external onlyManager {
        Listing storage listing = listings[tokenId]; // Get the listing for the token
        listing.inspectionPassed = passed; // Set the inspection status
    }
}