/*
 ________    _______     ______  ___      ___  __
|"      "\  /"      \   /    " \|"  \    /"  |/""\
(.  ___  :)|:        | // ____  \\   \  //  //    \
|: \   ) |||_____/   )/  /    ) :)\\  \/. .//' /\  \
(| (___\ || //      /(: (____/ //  \.    ////  __'  \
|:       :)|:  __   \ \        /    \\   //   /  \\  \
(________/ |__|  \___) \"_____/      \__/(___/    \___)

https://drova.io/
Knock yourself out.
*/
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/token/ERC20/IERC20.sol";
import "@openzeppelin/access/AccessControl.sol";
import "../interfaces/ILoyaltyProgramPaymentGateway.sol";

/**
    @title Loyalty Program Payment Gateway
    @notice enables users redeem their loyalty program tokens for playtime
    @author Gene A. Tsvigun
  */
contract LoyaltyProgramPaymentGateway is ILoyaltyProgramPaymentGateway, AccessControl {
    bytes32 public constant BOOKKEEPER = keccak256("BOOKKEEPER");

    IERC20 public token;
    address public paymentReceiver;
    address public commissionReceiver;
    uint256 public commissionPercentage;

    constructor(
        address _token,
        address _paymentReceiver,
        address _commissionReceiver,
        uint256 _commissionPercentage
    ){
        token = IERC20(_token);
        paymentReceiver = _paymentReceiver;
        commissionReceiver = _commissionReceiver;
        commissionPercentage = _commissionPercentage;
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    function redeemHours(uint256 amount) external {
        uint256 commission = amount * commissionPercentage / 100;
        uint256 payment = amount - commission;
        token.transferFrom(msg.sender, paymentReceiver, payment);
        token.transferFrom(msg.sender, commissionReceiver, commission);
        emit HoursRedeemed(msg.sender, paymentReceiver, commissionReceiver, payment, commission);
    }


    function setPaymentReceiver(address _paymentReceiver) external onlyRole(BOOKKEEPER) {
        paymentReceiver = _paymentReceiver;
    }

    function setCommissionReceiver(address _commissionReceiver) external onlyRole(BOOKKEEPER) {
        commissionReceiver = _commissionReceiver;
    }

    function setCommissionPercentage(uint256 _commissionPercentage) external onlyRole(BOOKKEEPER) {
        commissionPercentage = _commissionPercentage;
    }
}
