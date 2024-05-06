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


    //  Declare state variables
    address public nftAddress; // declare public nft address
    address payable public seller; // public seller address
    address public inspector; // inspector address
    address public lender; // lender address


    // -------------------------------------------------------------------------------------

    // Define the Modifiers

    // Modifiers: to add additional conditions, typically used to enforce access control or validate certain conditions

    modifier onlyBuyer(uint256 _nftID) {
        require(msg.sender == buyer[_nftID], "Only buyer can call this method"); // checks if the caller is the buyer of the NFT
        _; // returns the address of the buyer 
    }
    // Simply check on this line if the caller is the buyer of the NFT. If not, it will revert with the error message "Only buyer can call this method".

    modifier onlySeller() {
        require(msg.sender == seller, "Only seller can call this method");
        _;
    }
    // This modifier that checks if the caller is the seller.

    modifier onlyInspector() {
        require(msg.sender == inspector, "Only inspector can call this method");
        _;
    }
    // This modifier that checks if the caller is the inspector.

    // -------------------------------------------------------------------------------------

    // Define the mappings (metadata connections between the NFT and the contract)
    // The mappings are used to store information about each NFT

    mapping(uint256 => bool) public isListed; // to check if the NFT is listed
    mapping(uint256 => uint256) public purchasePrice;
    mapping(uint256 => uint256) public escrowAmount;
    mapping(uint256 => address) public buyer;
    mapping(uint256 => bool) public inspectionPassed;
    mapping(uint256 => mapping(address => bool)) public approval;

    // -------------------------------------------------------------------------------------

    // Define the constructor function (initialize the contract with the NFT address, seller, inspector, and lender)
    // Executed only once when the contract is deployed
    // So this is like a solid definition of fields, where ( at the deployment ) you define that in this field everyone is putting the seller's name, and this field is for the nft address ...etc
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

    // -------------------------------------------------------------------------------------
    //  Our logic is that we are specifing the buyer while listing the property for sale, if we did not want to do this we should do the following:
    // 1- Remove the buyer from the list function
    // 2- Add a new function to set the buyer address
            // Buy NFT (anyone can call)
            // function buy(uint256 _nftID) public {
            //     require(isListed[_nftID], "NFT is not listed for sale");
            //     buyer[_nftID] = msg.sender;
            // } 
    // Lots of complications so we are sticking with this is a smart contract reserver not booking   
    

    // List NFT for Sale (only seller)
    function list(
        // Define the needed parameters for the function
        uint256 _nftID,
        address _buyer,
        uint256 _purchasePrice,
        uint256 _escrowAmount
    ) public payable onlySeller { // Only the seller can call this function (check onlyseller before excuting)
    
        // Transfer NFT from seller to this contract
        IERC721(nftAddress).transferFrom(msg.sender, address(this), _nftID);

        isListed[_nftID] = true;
        purchasePrice[_nftID] = _purchasePrice;
        escrowAmount[_nftID] = _escrowAmount;
        buyer[_nftID] = _buyer;
    }
    // It transfers the NFT from the seller to the contract and stores the buyer, purchase price, and escrow amount.


    // -------------------------------------------------------------------------------------


    // Put Under Contract (only buyer - payable escrow)
    function depositEarnest(uint256 _nftID) public payable onlyBuyer(_nftID) {
        require(msg.value >= escrowAmount[_nftID]); // deposit should be >= escrow amount
    }
    // Allows the buyer to deposit the escrow amount. 

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
    // -> Require inspection status to be approved
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

        isListed[_nftID] = false; // remove listing

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