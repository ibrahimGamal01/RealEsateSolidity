// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./RealEstateEscrow.sol";

contract RealEstateEscrowMigration {
    RealEstateEscrow public realEstateEscrow;

    constructor() {
        realEstateEscrow = new RealEstateEscrow();
    }

    function migrate(address to, uint tokenId) external {
        realEstateEscrow.mint(to, tokenId);
    }

    function getListings(uint tokenId) external view returns (uint, bool, address, bool) {
        return (
            realEstateEscrow.listings(tokenId).price,
            realEstateEscrow.listings(tokenId).isListed,
            realEstateEscrow.listings(tokenId).buyer,
            realEstateEscrow.listings(tokenId).inspectionPassed
        );
    }
}
