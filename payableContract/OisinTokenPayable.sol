// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

contract OisinTokenPayable is IERC20 {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 private _totalSupply;
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;
    
    address public owner;
    uint256 public ticketPrice;
    uint256 public maxTickets;
    uint256 public soldTickets;
    
    event TicketPurchased(address indexed buyer, uint256 amount);
    event TicketReturned(address indexed returner, uint256 amount);

    constructor(string memory _name, string memory _symbol, uint8 _decimals, uint256 initialSupply, uint256 _ticketPrice, uint256 _maxTickets) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        ticketPrice = _ticketPrice;
        maxTickets = _maxTickets;
        soldTickets = 0;
        owner = msg.sender;
        
        _totalSupply = initialSupply * 10**uint256(decimals);
        _balances[msg.sender] = _totalSupply;
        emit Transfer(address(0), msg.sender, _totalSupply);
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    function totalSupply() external view override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) external view override returns (uint256) {
        return _balances[account];
    }

    function transfer(address recipient, uint256 amount) external override returns (bool) {
        _transfer(msg.sender, recipient, amount);
        return true;
    }

    function allowance(address tokenOwner, address spender) external view override returns (uint256) {
        return _allowances[tokenOwner][spender];
    }

    function approve(address spender, uint256 amount) external override returns (bool) {
        _approve(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) external override returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, msg.sender, _allowances[sender][msg.sender] - amount);
        return true;
    }

    function _transfer(address sender, address recipient, uint256 amount) internal {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");
        require(_balances[sender] >= amount, "ERC20: transfer amount exceeds balance");
        
        _balances[sender] -= amount;
        _balances[recipient] += amount;
        emit Transfer(sender, recipient, amount);
    }

    function _approve(address tokenOwner, address spender, uint256 amount) internal {
        require(tokenOwner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[tokenOwner][spender] = amount;
        emit Approval(tokenOwner, spender, amount);
    }

    function buyTicket(uint256 _numTickets) external payable {
        require(_numTickets > 0, "Must purchase at least one ticket");
        require(soldTickets + _numTickets <= maxTickets, "Not enough tickets available");
        require(msg.value >= ticketPrice * _numTickets, "Insufficient payment");
        
        _transfer(owner, msg.sender, _numTickets);
        
        soldTickets += _numTickets;
        
        emit TicketPurchased(msg.sender, _numTickets);
    }
    
    function returnTicket(uint256 _numTickets) external {
        require(_numTickets > 0, "Must return at least one ticket");
        require(_balances[msg.sender] >= _numTickets, "Not enough tickets to return");
        
        _transfer(msg.sender, owner, _numTickets);
        
        soldTickets -= _numTickets;
        
        emit TicketReturned(msg.sender, _numTickets);
    }
    
    function setTicketPrice(uint256 _newPrice) external onlyOwner {
        ticketPrice = _newPrice;
    }
    
    function withdrawFunds() external onlyOwner {
        payable(owner).transfer(address(this).balance);
    }
    
    function availableTickets() external view returns (uint256) {
        return maxTickets - soldTickets;
    }
}
