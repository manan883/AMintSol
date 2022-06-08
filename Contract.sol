// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "erc721a/contracts/ERC721A.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract aMint is 
    Ownable, 
    ERC721A, 
    ReentrancyGuard
{
        bool saleActive = false;
    constructor(string memory name, string memory symbol,string memory baseURI) ERC721A(name, symbol){
        setBaseURI(baseURI);
        saleActive = false;
        name = "Nifty";
    }
    //token vars
    uint256 maxTokens = 1111;
    uint256 maxMintPerTx = 10;
    uint256 totalReserve;
    uint256 reservedTokens = 100;
    //contract vars
    string public baseTURI;
function reserveTokens(address to, uint256 numOfTokens) public onlyOwner{
    require(totalSupply() + numOfTokens <= maxTokens);
    require(totalReserve + numOfTokens <= reservedTokens);
    _safeMint(to,numOfTokens);
    totalReserve = totalReserve + numOfTokens;
}
function setBaseURI(string memory baseURI) public onlyOwner{
    baseTURI = baseURI;
}
function setMaxTokens(uint256 max) public onlyOwner{
    maxTokens = max;
}
function baseTokenURI() internal view virtual returns (string memory){
    return baseTURI;
}
function MaxSupply() public view returns(uint256){
    return maxTokens;
}
function isSalePublic() public view returns(bool){
    return saleActive;
}

function setSalePublic() public onlyOwner{
    saleActive = true;
}
function mintTokens(uint256 numTokens) external {
    require(saleActive == true);
    require(numTokens < maxMintPerTx);
    require(numTokens > 0);
    require(numTokens + totalSupply() <= maxTokens);
    _safeMint(msg.sender,numTokens);
}



}
