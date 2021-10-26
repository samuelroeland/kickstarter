pragma solidity ^0.4.17;

contract Campaign {
    address public manager;
    uint public minimumContribution;
    address[] public approvers;
    
    struct Request{
        string description; // describes why the request is being created
        uint value; // amount of money that the manager wants to send to the vendor;
        address recipient; // address taht the money will be send to, receiver of money
        bool complete; // true if the request has already been processed (money sent)
    }
    
    Request[] public requests;
    
    
    modifier restricted() {
        require(msg.sender == manager);
        _;
        
    }
    
    constructor(uint _minimum){
        manager = msg.sender; 
        minimumContribution = _minimum;
    }
    
    function contribute() public payable{
        require(msg.value > minimumContribution);
        approvers.push(msg.sender); 
         
    }
    
    
    
    function createRequest(string memory _description, uint _value, address _recipient, bool _complete) public restricted{
        Request storage newRequest = Request({
            description: _description,
            value: _value,
            recipient: _recipient,
            complete: false
        });
        requests.push(newRequest);
    }
}