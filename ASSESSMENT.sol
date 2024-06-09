// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;
contract Scm{
    address payable public _Owner_;
    uint256 public _Balance;
    
    event _Depositing(uint256 AMOUNT);
    event _Withdrawing(uint256 AMOUNT);

    constructor(uint Initial_Balance) payable {
        _Owner_ = payable(msg.sender);
        _Balance = Initial_Balance;
    }

    function get_Balance() public view returns(uint){
        return _Balance;
    }

    function depositing(uint _amount_) public payable {
        uint _previous_Balance = _Balance;
        require(msg.sender == _Owner_, "we are extreamlly sorry to say that You are not the owner of this account");
        _Balance = _Balance + _amount_;
        assert(_Balance == _previous_Balance + _amount_);
        emit _Depositing(_amount_);
    }

    error _Insufficient_Balance_(uint balance, uint withdraw_Amount);
    function withdraw(uint _withdrawing_Amount) public {
        require(msg.sender == _Owner_, "we are extreamlly sorry to say that You are not the owner of this account");
        uint _previous_Balance = _Balance;
        if (_Balance < _withdrawing_Amount) {
            revert _Insufficient_Balance_({
                balance: _Balance,
                withdraw_Amount: _withdrawing_Amount
            });
        }
        _Balance = _Balance - _withdrawing_Amount;
        assert(_Balance == (_previous_Balance - _withdrawing_Amount));
        emit _Withdrawing(_withdrawing_Amount);
    }
}
