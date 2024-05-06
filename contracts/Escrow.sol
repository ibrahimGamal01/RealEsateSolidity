//SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.0;

interface IERC721 {
    function transferFrom(
        address _from,
        address _to,
        uint256 _id
    ) external;
}
// Interface for the ERC721 standard.
// declares function `transferFrom`: used to transfer a token from one address to another.

contract Escrow {
// Define New contract `Escrow`

    address public nftAddress; // declare public nft address
    address payable public seller; // public seller address
    address public inspector; // inspector address
    address public lender; // lender address
// ---------------------------------------
    modifier onlyBuyer(uint256 _nftID) {
        require(msg.sender == buyer[_nftID], "Only buyer can call this method");
        _;
    }
    // This is a modifier that checks if the caller is the buyer of the NFT.

    modifier onlySeller() {
        require(msg.sender == seller, "Only seller can call this method");
        _;
    }
    // This is a modifier that checks if the caller is the seller.

    modifier onlyInspector() {
        require(msg.sender == inspector, "Only inspector can call this method");
        _;
    }
    // This is a modifier that checks if the caller is the inspector.

    mapping(uint256 => bool) public isListed;
    mapping(uint256 => uint256) public purchasePrice;
    mapping(uint256 => uint256) public escrowAmount;
    mapping(uint256 => address) public buyer;
    mapping(uint256 => bool) public inspectionPassed;
    mapping(uint256 => mapping(address => bool)) public approval;
    // These lines declare mappings to store various information about each NFT, such as whether it is listed, its purchase price, escrow amount, buyer, inspection status, and approval status.

    constructor(
        address _nftAddress,
        address payable _seller,
        address _inspector,
        address _lender
    ) {
        nftAddress = _nftAddress;
        seller = _seller;
        inspector = _inspector;
        lender = _lender;
    }
    // The constructor function is a special function that is executed only once when the contract is deployed. In this case, it sets the NFT address, seller, inspector, and lender.

    function list(
        uint256 _nftID,
        address _buyer,
        uint256 _purchasePrice,
        uint256 _escrowAmount
    ) public payable onlySeller {
        // Transfer NFT from seller to this contract
        IERC721(nftAddress).transferFrom(msg.sender, address(this), _nftID);

        isListed[_nftID] = true;
        purchasePrice[_nftID] = _purchasePrice;
        escrowAmount[_nftID] = _escrowAmount;
        buyer[_nftID] = _buyer;
    }
    // This function allows the seller to list an NFT for sale. It transfers the NFT from the seller to the contract and stores the buyer, purchase price, and escrow amount.

    // Put Under Contract (only buyer - payable escrow)
    function depositEarnest(uint256 _nftID) public payable onlyBuyer(_nftID) {
        require(msg.value >= escrowAmount[_nftID]);
    }
    // This function allows the buyer to deposit the escrow amount. It checks that the deposited amount is at least equal to the escrow amount.

    // Update Inspection Status (only inspector)
    function updateInspectionStatus(uint256 _nftID, bool _passed)
        public
        onlyInspector
    {
        inspectionPassed[_nftID] = _passed;
    }
    // This function allows the inspector to update the inspection status of the NFT.

    // Approve Sale
    function approveSale(uint256 _nftID) public {
        approval[_nftID][msg.sender] = true;
    }
    // This function allows any address to approve the sale of the NFT.

    // Finalize Sale
    // -> Require inspection status (add more items here, like appraisal)
    // -> Require sale to be authorized
    // -> Require funds to be correct amount
    // -> Transfer NFT to buyer
    // -> Transfer Funds to Seller
    function finalizeSale(uint256 _nftID) public {
        require(inspectionPassed[_nftID]);
        require(approval[_nftID][buyer[_nftID]]);
        require(approval[_nftID][seller]);
        require(approval[_nftID][lender]);
        require(address(this).balance >= purchasePrice[_nftID]);

        isListed[_nftID] = false;

        (bool success, ) = payable(seller).call{value: address(this).balance}(
            ""
        );
        require(success);

        IERC721(nftAddress).transferFrom(address(this), buyer[_nftID], _nftID);
    }
    // This function finalizes the sale of the NFT. It checks that the inspection has passed, the sale is approved, and the contract has enough funds. It then transfers the NFT to the buyer and the funds to the seller.

    // Cancel Sale (handle earnest deposit)
    // -> if inspection status is not approved, then refund, otherwise send to seller
    function cancelSale(uint256 _nftID) public {
        if (inspectionPassed[_nftID] == false) {
            payable(buyer[_nftID]).transfer(address(this).balance);
        } else {
            payable(seller).transfer(address(this).balance);
        }
    }
    // This function allows the sale to be cancelled. If the inspection has not passed, it refunds the buyer. Otherwise, it sends the funds to the seller.

    receive() external payable {}
    // This is a fallback function that allows the contract to receive funds.

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
    // This function returns the balance of the contract.
}