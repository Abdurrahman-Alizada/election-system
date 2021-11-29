pragma solidity >=0.7.0;

contract Election {
    
    struct Candidate{
        uint id;
        string name;
        uint voteCount;
    }
    mapping(address => bool) public voted;
    mapping(uint => Candidate) public candidates;
    uint public candidatesCount;
    
    event electionUpdated(
        uint indexed _candidateId
        );

    constructor() {
        addCandidate("Ali");
        addCandidate("Hassan");
    }
    
    function addCandidate(string memory name) private {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, name, 0);
    } 
    
    function Vote(uint _candidateId) public {

        require(!voted[msg.sender], "You have Voted once");
        require(_candidateId > 0 && _candidateId <= candidatesCount, "The id dose not exist");
        candidates[_candidateId].voteCount += 1;
        voted[msg.sender] = true;
    emit electionUpdated(_candidateId);
    }
}