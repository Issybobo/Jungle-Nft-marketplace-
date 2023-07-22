// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;


import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "./JungleNft.sol";
import "./Pepecoin.sol";

contract JungleNftMarketplace {
    using Address for address payable;

    // List out NftListing data.
    struct NFTListing {
        address seller;
        address nftContract;
        uint256 tokenId;
        uint256 price;
        bool isAvailable;
    }

    mapping(uint256 => NFTListing) private nftListings;

    event NFTListed(address indexed seller, address indexed nftContract, uint256 indexed tokenId, uint256 price);
    event NFTSold(address indexed buyer, address indexed seller, address indexed nftContract, uint256 tokenId, uint256 price);


    
    // Function to list an NFT for sale.
    function listNFT(address nftContract, uint256 tokenId, uint256 price) external {

        require(price > 0, "Price must be greater than zero");
        require(
            IERC721(nftContract).ownerOf(tokenId) == msg.sender,
            "Only the owner can list the NFT"
        );
        IERC721(nftContract).transferFrom(msg.sender, address(this), tokenId);
        
        // Stores the NFT listing details
        nftListings[tokenId] = NFTListing({
            seller: msg.sender,
            nftContract: nftContract,
            tokenId: tokenId,
            price: price,
            isAvailable: true
        });
        emit NFTListed(msg.sender, nftContract, tokenId, price);
    }

    
    // Function to cancel listing
    function cancelListing(uint256 tokenId) external {
        NFTListing storage listing = nftListings[tokenId];
        require(listing.isAvailable, "NFT is not listed for sale");
        require(listing.seller == msg.sender, "You are not the seller");
        IERC721(listing.nftContract).transferFrom(address(this), msg.sender, tokenId);
        delete nftListings[tokenId];
    }

    
    // Function to buy nft
    function buyNFT(uint256 tokenId) external payable {
        NFTListing storage listing = nftListings[tokenId];
        require(listing.isAvailable, "NFT is not listed for sale");
        require(msg.value >= listing.price, "Insufficient payment");
        listing.isAvailable = false;
        IERC721(listing.nftContract).transferFrom(address(this), msg.sender, tokenId);
        payable(listing.seller).sendValue(listing.price);
        emit NFTSold(msg.sender, listing.seller, listing.nftContract, tokenId, listing.price);
    }

    // Function to get the nft listing data
    function getNFTListing(uint256 tokenId) public view returns (NFTListing memory) {
        return nftListings[tokenId];
    }
}