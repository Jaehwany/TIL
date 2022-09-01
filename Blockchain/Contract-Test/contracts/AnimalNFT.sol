// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

/*
* 동물 NFT 티켓을 ERC-721 Token(NFT)으로 생성하는 Contract
*/

contract AnimalNFT is ERC721Enumerable {
  
    using Counters for Counters.Counter;

    //IERC721Metadata
    Counters.Counter private _tokenIds;
    mapping(uint256 => string) private _tokenURIs;

    // 멸종 동물 등급(Contract) 저장을 위한 mapping
    mapping(uint256 => uint256) private _classes;
    
    // NFT 토큰 발행 지갑의 Address 저장을 위한 mapping
    mapping(uint256 => address) private _minters;

    constructor() ERC721("AnimalNFT", "AFT") public {}

    /*
    * create
    * 새로운 동물 정보를 가진 ERC-721 토큰을 생성
    * 메타데이터(IPFS) URI와 data를 받아 새로운 토큰을 발급
    * 토큰에 관한 정보는 Contract의 mapping에 저장
    * 
    * @ param uint256 tokenId 생성된 티켓의 토큰 아이디
    * @ return None
    * @ exception None
    */
    function create(string memory animalURI, uint256 class) public returns (uint256) {
        _tokenIds.increment();

        uint256 newTokenId = _tokenIds.current();
        _mint(msg.sender, newTokenId);
        _setMinter(newTokenId, msg.sender);
        _setTokenURI(newTokenId, animalURI);
        _setClass(newTokenId, class);

        return newTokenId;
    }

    // ERC721URIStorage: TokenURI setter
    function _setTokenURI(uint256 tokenId, string memory _tokenURI) internal virtual {
        require(_exists(tokenId), "ERC721URIStorage: URI set of nonexistent token");
        _tokenURIs[tokenId] = _tokenURI;
    }

    function _setMinter(uint256 tokenId, address minter) private {
        _minters[tokenId] = minter;
    }

    function _setClass(uint256 tokenId, uint256 class) private {
        _classes[tokenId] = class;
    }

    function getTokenURI(uint256 tokenId) public view returns (string memory) {
        return _tokenURIs[tokenId];
    }

    function getMinter(uint256 tokenId) public view returns (address) {
        return _minters[tokenId];
    }

    function getClass(uint256 tokenId) public view returns (uint256) {
        return _classes[tokenId];
    }

}