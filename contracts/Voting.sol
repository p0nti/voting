// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    struct Proposal {
        string description;
        uint256 votes;
    }

    Proposal[] public proposals;
    mapping(address => mapping(uint256 => bool)) public hasVoted;

    event ProposalCreated(uint256 proposalId, string description);
    event Voted(address voter, uint256 proposalId);

    // Create a new proposal
    function createProposal(string memory description) public {
        proposals.push(Proposal(description, 0));
        emit ProposalCreated(proposals.length - 1, description);
    }

    // Vote for a proposal
    function vote(uint256 proposalId) public {
        require(proposalId < proposals.length, "Invalid proposal");
        require(!hasVoted[msg.sender][proposalId], "Already voted");

        proposals[proposalId].votes++;
        hasVoted[msg.sender][proposalId] = true;

        emit Voted(msg.sender, proposalId);
    }

    // Get the winning proposal
    function getWinningProposal() public view returns (uint256 winningProposalId) {
        uint256 highestVotes = 0;

        for (uint256 i = 0; i < proposals.length; i++) {
            if (proposals[i].votes > highestVotes) {
                highestVotes = proposals[i].votes;
                winningProposalId = i;
            }
        }
    }
}

