# Real estate Blockchain App

Each property is and individual NFT, when youtry to buy the property it goes into escrow witing to be apporved by othe parties and funded before finalizing the transaction 


Create an NFT (non-fundable token) collection to manage the properties

## Smart Contracts
1. Real estate NFT : Governance of the property
2. Escrow Contract: Manage the puchase of the property




## Using 
- Solidity
- Hardhat: Ethereum development environment
- OpenZeppelin: We are gonna use this library to help create the NFT as it hard to create it from scratch.
    - where you can use sb else’s NFT code into ur project https://www.openzeppelin.com/
- ERC-721 NON-FUNGIBLE TOKEN (NFT) STANDARD: Pictures are the NFT's
    - with metadata:
        - Price 
        - Square feet
        - Year Built
        - Bedrooms
        - Bathrooms
        - Type of residence
        - The picture 
- Using InterPlanetary File System (IPFS) :to create a content-addressable, peer-to-peer method of storing and sharing hypermedia
    - In IPFS, each file and all of the blocks within it are given a unique fingerprint.
    - When you look up a file on IPFS, you're asking the network to find nodes that are storing the content behind that file's hash.
    - 

## Metadata 
Sample
```json
{
    "name": "Elegant NYC Loft",
    "address": "123 Main St APT 5B, New York, NY 10001",
    "description": "Elegant Loft located in a vibrant NYC neighborhood",
    "image": "https://ipfs.io/ipfs/QmQUozrHLAusXDxrvsESJ3PYB3rUeUuBAvVWw6nop2uu7c/2.png",
    "id": "2",
    "attributes": [
        {
            "trait_type": "Purchase Price",
            "value": 15
        },
        {
            "trait_type": "Type of Residence",
            "value": "Loft"
        },
        {
            "trait_type": "Bed Rooms",
            "value": 1
        },
        {
            "trait_type": "Bathrooms",
            "value": 1
        },
        {
            "trait_type": "Square Feet",
            "value": 1500
        },
        {
            "trait_type": "Year Built",
            "value": 2005
        }
    ]
}
```


 