// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "./utils/ExistingDeploymentParser.sol";

/**
 * @notice Script used for the first deployment of theweb3ChainLayer core contracts to theweb3 chain
 * forge script script/DeployerBasic.s.sol --rpc-url http://127.0.0.1:8545 --private-key $PRIVATE_KEY --broadcast -vvvv
 * forge script script/DeployerBasic.s.sol --rpc-url $RPC_URL --private-key $PRIVATE_KEY --broadcast -vvvv
 */
contract DeployerBasic is ExistingDeploymentParser {
    function run() external virtual {
        _parseInitialDeploymentParams("script/configs/Deployment.config.json");

        // START RECORDING TRANSACTIONS FOR DEPLOYMENT
        vm.startBroadcast();

        emit log_named_address("Deployer Address", msg.sender);

        _deployFromScratch();

        // STOP RECORDING TRANSACTIONS FOR DEPLOYMENT
        vm.stopBroadcast();

        // Sanity Checks
        //        _verifyContractPointers();
        //        _verifyImplementations();
        //        _verifyContractsInitialized();
        //        _verifyInitializationParams();

        logAndOutputContractAddresses("script/output/DeploymentBasic.config.json");
    }

    /**
     * @notice Deploy theweb3ChainLayer contracts from scratch for theweb3 Chain
     */
    function _deployFromScratch() internal {
        // Deploy ProxyAdmin, later set admins for all proxies to be executorMultisig
        fdChainLayerProxyAdmin = new ProxyAdmin(executorMultisig);

        // Set multisigs as pausers, executorMultisig as unpauser
        address[] memory pausers = new address[](3);
        pausers[0] = executorMultisig;
        pausers[1] = operationsMultisig;
        pausers[2] = pauserMultisig;
        address unpauser = executorMultisig;
        fdChainLayerPauserReg = new PauserRegistry(pausers, unpauser);

        emptyContract = new EmptyContract();

        // Deploy and upgrade chainBase
        TransparentUpgradeableProxy chainBaseBaseProxyInstance =
            new TransparentUpgradeableProxy(address(emptyContract), executorMultisig, "");
        fdChainBase = FdChainBase(payable(address(chainBaseBaseProxyInstance)));
        chainBaseBaseProxyAdmin = ProxyAdmin(getProxyAdminAddress(address(chainBaseBaseProxyInstance)));

        TransparentUpgradeableProxy delegationManagerProxyInstance =
            new TransparentUpgradeableProxy(address(emptyContract), executorMultisig, "");
        delegationManager = DelegationManager(payable(address(delegationManagerProxyInstance)));
        delegationManagerProxyAdmin = ProxyAdmin(getProxyAdminAddress(address(delegationManagerProxyInstance)));

        TransparentUpgradeableProxy fdChainDepositManagerProxyInstance =
            new TransparentUpgradeableProxy(address(emptyContract), executorMultisig, "");
        fdChainDepositManager = FdChainDepositManager(payable(address(fdChainDepositManagerProxyInstance)));
        fdChainDepositManagerProxyAdmin = ProxyAdmin(getProxyAdminAddress(address(fdChainDepositManagerProxyInstance)));

        TransparentUpgradeableProxy rewardManagerProxyInstance =
            new TransparentUpgradeableProxy(address(emptyContract), executorMultisig, "");
        rewardManager = RewardManager(payable(address(rewardManagerProxyInstance)));
        rewardManagerProxyAdmin = ProxyAdmin(getProxyAdminAddress(address(rewardManagerProxyInstance)));

        TransparentUpgradeableProxy slashingManagerProxyInstance =
            new TransparentUpgradeableProxy(address(emptyContract), executorMultisig, "");
        slashingManager = SlashingManager(payable(address(slashingManagerProxyInstance)));
        slashingManagerProxyAdmin = ProxyAdmin(getProxyAdminAddress(address(slashingManagerProxyInstance)));

        delegationManagerImplementation = new DelegationManager();
        fdChainDepositManagerImplementation = new FdChainDepositManager();
        fdChainBaseImplementation = new FdChainBase();
        rewardManagerImplementation = new RewardManager();
        slashingManagerImplementation = new SlashingManager();

        // DelegationManager
        delegationManagerProxyAdmin.upgradeAndCall(
            ITransparentUpgradeableProxy(payable(address(delegationManager))),
            address(delegationManagerImplementation),
            abi.encodeWithSelector(
                DelegationManager.initialize.selector,
                executorMultisig, // initialOwner
                fdChainLayerPauserReg,
                DELEGATION_MANAGER_INIT_PAUSED_STATUS,
                0,
                fdChainDepositManager,
                fdChainBase,
                slashingManager
            )
        );
        // fdChainDepositManager
        fdChainDepositManagerProxyAdmin.upgradeAndCall(
            ITransparentUpgradeableProxy(payable(address(fdChainDepositManager))),
            address(fdChainDepositManagerImplementation),
            abi.encodeWithSelector(
                fdChainDepositManager.initialize.selector,
                msg.sender, //initialOwner, set to executorMultisig later after whitelisting strategies
                address(delegationManagerProxyInstance),
                address(chainBaseBaseProxyInstance)
            )
        );

        // fdChainBase
        chainBaseBaseProxyAdmin.upgradeAndCall(
            ITransparentUpgradeableProxy(payable(address(fdChainBase))),
            address(fdChainBaseImplementation),
            abi.encodeWithSelector(
                fdChainBase.initialize.selector,
                fdChainLayerPauserReg,
                theweb3ChainBASE_MIN_DEPOSIT,
                theweb3ChainBASE_MAX_DEPOSIT,
                fdChainDepositManager
            )
        );

        slashingManagerProxyAdmin.upgradeAndCall(
            ITransparentUpgradeableProxy(payable(address(slashingManager))),
            address(slashingManagerImplementation),
            abi.encodeWithSelector(
                SlashingManager.initialize.selector,
                executorMultisig,
                delegationManager,
                executorMultisig,
                1000,
                executorMultisig
            )
        );

        // Transfer ownership
        fdChainDepositManager.transferOwnership(executorMultisig);
        fdChainLayerProxyAdmin.transferOwnership(executorMultisig);
    }
}
