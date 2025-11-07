// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin-upgrades/contracts/proxy/utils/Initializable.sol";
import "@openzeppelin-upgrades/contracts/access/OwnableUpgradeable.sol";
import "@openzeppelin-upgrades/contracts/utils/ReentrancyGuardUpgradeable.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

import "../../interfaces/IRewardManager.sol";
import "../../interfaces/IDelegationManager.sol";
import "../../interfaces/IFdChainDepositManager.sol";

abstract contract RewardManagerStorage is
    Initializable,
    OwnableUpgradeable,
    ReentrancyGuardUpgradeable,
    IRewardManager
{
    IDelegationManager public delegationManager;

    IFdChainDepositManager public fdChainDepositManager;

    uint256 public stakePercent;

    address public rewardManager;

    address public payFeeManager;

    mapping(address => uint256) public operatorRewards;
    mapping(address => mapping(address => uint256)) stakerRewards;

    function _initializeRewardManagerStorage(
        IDelegationManager _delegationManager,
        IFdChainDepositManager _fdChainDepositManager
    ) internal {
        delegationManager = _delegationManager;
        fdChainDepositManager = _fdChainDepositManager;
    }

    uint256[100] private __gap;
}
