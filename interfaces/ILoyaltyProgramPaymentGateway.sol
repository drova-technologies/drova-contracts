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
import "@openzeppelin/access/IAccessControl.sol";

/**
    @title Loyalty Program Payment Gateway interface
    @notice enables users redeem their loyalty program tokens for playtime
    @author Gene A. Tsvigun
  */
interface ILoyaltyProgramPaymentGateway is IAccessControl {
    event HoursRedeemed(
        address indexed from,
        address indexed to,
        address indexed commissionReceiver,
        uint256 payment,
        uint256 commission);

    function redeemHours(uint256 amount) external;

    function setPaymentReceiver(address paymentReceiver) external;

    function setCommissionReceiver(address commissionReceiver) external;

    function setCommissionPercentage(uint256 commissionPercentage) external;

    function token() external view returns (IERC20);

    function BOOKKEEPER() external view returns (bytes32);
}
