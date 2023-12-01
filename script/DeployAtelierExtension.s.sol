// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {AtelierBurnRedeemExistingExtension, ERC721Burnable} from "../src/AtelierBurnRedeemExistingExtension.sol";
import {IERC1155Creator} from "../src/IERC1155Creator.sol";

contract CounterScript is Script {
    address adminOzzz = 0x3e37FF7bCC7dCfc3E93368e4FEBcD90840d83f86;
    address holderOzzz = 0xD6568542b1f65bB18A45d710B1072dC73225B840;
    IERC1155Creator newContract = IERC1155Creator(0x6D90aA894d7C845c248c8866aA246ac378aA15bf);
    ERC721Burnable oldContract = ERC721Burnable(0x670EaB9e367a2f51441Fce97A4a809437ffE8181);

    function setUp() public {
        AtelierBurnRedeemExistingExtension atelierExtension = new AtelierBurnRedeemExistingExtension();

        vm.startPrank(adminOzzz);
        newContract.registerExtension(address(atelierExtension), "");
        newContract.approveAdmin(address(atelierExtension));
        newContract.approveAdmin(address(adminOzzz));
        console2.log(newContract.isAdmin(0x71c5eb9C75f44D8C5D276DAE9423C867E6E63a61));
        console2.log(newContract.isAdmin(adminOzzz));
        atelierExtension.setEligible(1, true);
        vm.stopPrank();

        vm.startPrank(holderOzzz);
        oldContract.setApprovalForAll(address(atelierExtension), true);

        uint256[] memory tokenIds = new uint256[](1);
        tokenIds[0] = 1;
        uint256[] memory amounts = new uint256[](1);
        amounts[0] = 1;
        atelierExtension.burnRedeem(tokenIds, amounts, 13);
    }

    function run() public {
        vm.startBroadcast();

        setUp();

        vm.stopBroadcast();
    }
}
