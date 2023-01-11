// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

pragma solidity ^0.8.0;

contract Locker{

    mapping(address => mapping(IERC20 => uint256)) public tokenLocked;
    using SafeMath for uint256;
    using SafeERC20 for IERC20;
    event TokensLocked(
        address user,
        IERC20 token,
        uint256 amount
    );

    event TokensUnlocked(
        address user,
        IERC20 token,
        uint256 amount
    );

    function lockToken(IERC20 token, uint256 _amount) public {
        require(token.balanceOf(msg.sender)>=_amount);
        token.safeTransferFrom(
            msg.sender,
            address(this),
            _amount
        );
        tokenLocked[msg.sender][token] = _amount;
        emit TokensLocked(
            msg.sender,
            token,
            _amount
        );
    }

    function unLockToken(IERC20 token, uint256 _amount) public {
        require(tokenLocked[msg.sender][token]!=0 && tokenLocked[msg.sender][token]>=_amount);
        token.safeTransfer(
            msg.sender,
            _amount
        );

        uint256 lockAmount = tokenLocked[msg.sender][token];
        tokenLocked[msg.sender][token] = lockAmount.sub(_amount); 
        emit TokensUnlocked(
            msg.sender,
            token,
            _amount
        );
    }
}