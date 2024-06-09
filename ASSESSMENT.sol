// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;
contract Scm{
    address payable public _Owner_;
    uint256 public _Balance_;
    
    event _Depositing(uint256 AMOUNT);
    event _Withdrawing(uint256 AMOUNT);

    constructor(uint Initial_Balance) payable {
        _Owner_ = payable(msg.sender);
        _Balance_ = Initial_Balance;
    }

    function get_Balance() public view returns(uint){
        return _Balance_;
    }

    function depositing(uint _amount_) public payable {
        uint _previous_Balance = _Balance_;
        require(msg.sender == _Owner_, "we are extreamlly sorry to say that You are not the owner of this account");
        _Balance_ = _Balance_ + _amount_;
        assert(_Balance_ == _previous_Balance + _amount_);
        emit _Depositing(_amount_);
    }

    error _Insufficient_Balance_(uint balance, uint withdraw_Amount);
    function withdrawing(uint _withdrawing_Amount) public {
        require(msg.sender == _Owner_, "we are extreamlly sorry to say that You are not the owner of this account");
        uint _previous_Balance = _Balance_;
        if ( _withdrawing_Amount > _Balance_) {
            revert _Insufficient_Balance_({
                balance: _Balance_,
                withdraw_Amount: _withdrawing_Amount
            });
        }
        _Balance_ = _Balance_ - _withdrawing_Amount;
        assert(_Balance_ == (_previous_Balance - _withdrawing_Amount));
        emit _Withdrawing(_withdrawing_Amount);
    }
}
