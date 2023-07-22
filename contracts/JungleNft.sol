// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract JungleNft is ERC721URIStorage {

    // Using Counters library to keep track of tokenIds for newly minted NFTs.
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721("JungleNft", "JKNFT") {} 


    // The `mintNFT` function allows users to mint a new NFT by providing the recipient's address and the tokenURI.
    function mintNFT(address recipient, string memory tokenURI) external returns (uint256) {

        _tokenIds.increment();
        uint256 newTokenId = _tokenIds.current();
        _mint(recipient, newTokenId);
        _setTokenURI(newTokenId, tokenURI);
        return newTokenId;
    }
}