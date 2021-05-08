//SPDX-License-Identifier: SNU
pragma solidity ^0.8.0;

contract ERC20 {
    string private _name;
    string private _symbol;
    
    mapping (address => bool) private _isbeneficiary;
    
    //remain tokens
    mapping (address => uint256) private _balances;
    
    //accumulate amount of token donation
    mapping(address => uint256) private _totaldonation;
    
    mapping(address => uint256) private _totaldonator;
    
    mapping(address => mapping(address => uint256)) private _allowances;
    //tokens at first = 0
    uint256 private _initialtoken = 0;
    
    
    constructor (string memory name_, string memory symbol_, bool isbeneficiary_){
        
        _name = name_;
        _symbol = symbol_;
        _isbeneficiary[msg.sender] = isbeneficiary_;
        _totaldonator[msg.sender] = 0;
        _balances[msg.sender] = _initialtoken;
        _totaldonation[msg.sender] = _initialtoken;

    }
    
    function name() public view virtual returns (string memory){
        return _name;
    }
    
    function symbol() public view virtual returns (string memory){
        return _symbol;
    }
    
    function isbene(address account) public view virtual returns(bool){
        return _isbeneficiary[account];
    }
    function totaldonation(address account) public view virtual returns(uint256){
        return _totaldonation[account];
    }
    
    function balanceOf(address account) public view virtual returns (uint256) {
        return _balances[account];
    }
    function totaldonator(address account) public view virtual returns(uint256){
        require(_isbeneficiary[account] == true, "ERROR:A donator cannot have donator for him(her)self");
        return _totaldonator[account];
    }
    
    function allowance(address beneficiary, address donator) public view virtual returns (uint256){
        return _allowances[beneficiary][donator];
    }
    
    function approve(address donator, uint256 amount) public virtual returns (bool){
        _approve(msg.sender, donator, amount);
        return true;
    }
    
    function donate(address donator, address beneficiary, uint256 amount) internal virtual{
        require(donator !=address(0),"ERROR: transfer from the zero address");
        require(beneficiary !=address(0), "ERROR: transfer to the zero address");
        require(amount>=1, "ERROR: please donate more than minimal unit");
        
        uint256 donatorBalance = _balances[donator];
        require(donatorBalance >= amount, "ERROR: not enough token");
        
        _balances[donator] = donatorBalance - amount;
        _balances[beneficiary] += amount;
        _totaldonation[beneficiary] += amount;
        _totaldonation[donator] += amount; 
        _totaldonator[donator] += 1;
        
        emit Transfer(beneficiary, donator, amount);
        
    }
    
    function buytoken(address donator, uint256 amount) internal virtual{
        require(isbene(donator) != true, "ERROR: beneficiary cannot buy token");
        //buying tokens
    
        emit Transfer(address(0), donator, amount);
    }
    
    function selltoken(address beneficiary, uint256 amount) internal virtual{
        require(isbene(beneficiary) == true, "ERROR: refund is not allowed to donator");
        require(_balances[beneficiary] >= amount, "ERROR: not enough token");
        
        emit Transfer(beneficiary, address(0), amount);
        //sell token and give money to beneficiary
        
    }
    
    function _approve(address beneficiary, address donator, uint256 amount) internal virtual{
        require(_isbeneficiary[beneficiary] == true, "ERROR: cannot approve from donator");
        require(_isbeneficiary[donator]!=true, "ERROR: cannot approve to beneficiary");
        require(donator !=address(0),"ERROR: approve to the zero address");
        require(beneficiary !=address(0), "ERROR: approve from the zero address");
        
        _allowances[beneficiary][donator] = amount;
        emit Approval(beneficiary, donator, amount);
    }
    
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    }