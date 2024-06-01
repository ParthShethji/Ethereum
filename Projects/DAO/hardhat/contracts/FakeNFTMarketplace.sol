// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

contract  FakeNFTMarketplace{
    mapping (uint256 => address) public token;

    uint256 nftPrice = 0.1 ether;

    function purchase(uint256 token_id) external payable {
        require(msg.value == nftPrice, "this costs 0.1 ether");
        token[token_id]=msg.sender;
    }

    function price() external view returns(uint256) {
        return nftPrice;
    }

    function available(uint256 token_id) external view returns(bool){
        if(token[token_id]==address(0)){
            return true;
        }
        return false;
    }
}
