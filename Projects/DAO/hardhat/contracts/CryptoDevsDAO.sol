// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/access/Ownable.sol";

interface IFakeNFTMarketplace {
    function price() external view returns (uint256);

    function purchase(uint256 token_id) external payable;

    function available(uint256 token_id) external view returns (bool);
}

interface ICryptoDevsNFT {
    function balanceof(address owner) external view returns (uint256);

    function tokenofownerbyindex(
        address owner,
        uint256 index
    ) external view returns (uint256);
}

contract CryptoDevsDAO is Ownable {
    struct Proposal {
        uint256 nfttokenid;
        uint256 yayvotes;
        uint256 novotes;
        uint256 deadline;
        bool executed;
        mapping(uint256 => bool) voters;
    }

    mapping(uint256 => Proposal) public proposals;

    uint256 public numproposals;

    ICryptoDevsNFT cryptoDevsNFT;
    IFakeNFTMarketplace fakeNFTMarketplace;

    constructor(address _cryptoDevsNFT, address _fakeNFTMarketplace) payable {
        cryptoDevsNFT = ICryptoDevsNFT(_cryptoDevsNFT);
        fakeNFTMarketplace = IFakeNFTMarketplace(_fakeNFTMarketplace);
    }

    modifier onlyholder() {
        require(cryptoDevsNFT.balanceof(msg.sender) > 0, "not a member of dao");
        _;
    }

    function createproposal(
        uint256 nfttokenid
    ) external onlyholder returns (uint256) {
        require(fakeNFTMarketplace.available(nfttokenid), "not for sale");
        Proposal storage proposal = proposals[numproposals];
        proposal.nfttokenid = nfttokenid;

        proposal.deadline = block.timestamp + 5 minutes;
        numproposals++;
        return numproposals - 1;
    }

    modifier activeproposalonly(uint256 proposalindex) {
        require(
            proposals[proposalindex].deadline > block.timestamp,
            "deadline extended"
        );
        _;
    }

    enum Vote {
        yay,
        nay
    }

    function voteonproposal(
        uint256 proposalindex,
        Vote vote
    ) external onlyholder activeproposalonly(proposalindex) {
        Proposal storage proposal = proposals[proposalindex];
        uint256 voterNFTbalance = cryptoDevsNFT.balanceof(msg.sender);
        uint256 numVotes = 0;

        for (uint256 i = 0; i < voterNFTbalance; i++) {
            uint256 tokenId = cryptoDevsNFT.tokenofownerbyindex(msg.sender, i);
            if (proposal.voters[tokenId] == false) {
                numVotes++;
                proposal.voters[tokenId] = true;
            }
        }
        require(numVotes > 0, "Already voted");

        if (vote == Vote.yay) {
            proposal.yayvotes += numVotes;
        }
        else{
            proposal.novotes += numVotes;
        }
    }

    modifier inactiveProposalOnly(uint256 proposalindex){
        require(proposals[proposalindex].deadline<=block.timestamp, "Deadline is not exceeded");
        require(proposals[proposalindex].executed==false, "Proposal already executed");
        _;
    }

    function executeEvents(uint256 proposalIndex)external onlyholder inactiveProposalOnly(proposalIndex){
        Proposal storage proposal = proposals[proposalIndex];
        if (proposal.yayvotes > proposal.novotes) {
            uint256 nftprice = fakeNFTMarketplace.price();
            require(address(this).balance>= nftprice, "not enough balance");
            fakeNFTMarketplace.purchase{value: nftprice}(proposal.nfttokenid);
        }
        proposal.executed=true;
    }
    

    function weithdrawEther() external onlyOwner{
        uint256 amount = address(this).balance;
        require(amount>0, "nothing to withdraw ");
        (bool sent, )=  payable (owner()).call{value: amount}(" ");
        require(sent, "failed to withdraw");
    }

    receive() external payable{}
    fallback() external payable{}
}
