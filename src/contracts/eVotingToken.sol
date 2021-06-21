// SPDX-License-Identifier: MIT
pragma solidity >=0.4.0 <0.9.0;

interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceFor(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function transferFrom(address _from, address _to, uint256 _value) external returns (bool success);
    event Transfer(address indexed from, address indexed to, uint256 value);
}


contract eVotingToken is IERC20 {
    string  public name = "eVoting Token";
    string  public symbol = "eToken";
    uint256 public totalSupply = 1200000000000000000000000000; // 120 million tokens
    address public owner;
    
    event Transfer(
        address indexed _from,
        address indexed _to,
        uint256 _value
    );

    mapping(address => uint256) public balanceOf;

    constructor() public {
        owner = msg.sender;
        balanceOf[owner] = totalSupply;
    }

    // To get the token balance of a specific account using the address 
    function balanceFor(address _tokenAddress) public view returns (uint256 balance){
        return balanceOf[_tokenAddress];
    }
    
    // To transfer tokens to a specific address
    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(balanceOf[owner] >= _value, "Balance not enough");
        balanceOf[owner] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(owner, _to, _value);
        return true;
    }
    
    // To transfer tokens to from one address to a specific address
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(_value <= balanceOf[_from], "Sender Balance is low");
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(_from, _to, _value);
        return true;
    }
}