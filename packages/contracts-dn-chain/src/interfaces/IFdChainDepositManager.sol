// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {IFdChainBase} from "./IFdChainBase.sol";

interface IFdChainDepositManager {
    event Deposit(address staker, IFdChainBase chainbase, uint256 shares);

    event UpdatedThirdPartyTransfersForbidden(IFdChainBase chainbase, bool value);

    event FdChainBaseWhitelisterChanged(address previousAddress, address newAddress);

    event FdChainBaseAddedToDepositWhitelist(IFdChainBase chainbase);

    event FdChainBaseRemovedFromDepositWhitelist(IFdChainBase chainbase);

    function depositIntotheweb3Chain(uint256 amount) external payable returns (uint256 shares);

    function depositIntotheweb3ChainWithSignature(
        uint256 amount,
        address staker,
        uint256 expiry,
        bytes memory signature
    ) external payable returns (uint256 shares);

    function removeShares(address staker, uint256 shares) external;

    function addShares(address staker, uint256 shares) external;

    function withdrawSharesAsCp(address recipient, uint256 shares) external;

    function stakerFdChainBaseShares(address staker) external view returns (uint256 shares);

    function getDeposits(address staker) external view returns (uint256);
}
