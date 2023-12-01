// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {BurnAirdrop, ERC721Burnable} from "../src/BurnAirdrop.sol";
import {IERC1155Creator} from "../src/IERC1155Creator.sol";

contract CounterScript is Script {
    address adminOzzz = 0x3e37FF7bCC7dCfc3E93368e4FEBcD90840d83f86;
    address holderOzzz = 0xD6568542b1f65bB18A45d710B1072dC73225B840;
    address jailwarden = 0x4D04EB67A2D1e01c71FAd0366E0C200207A75487;
    IERC1155Creator newContract = IERC1155Creator(0x6D90aA894d7C845c248c8866aA246ac378aA15bf);
    ERC721Burnable oldContract = ERC721Burnable(0x670EaB9e367a2f51441Fce97A4a809437ffE8181);
    address private lazyAirdrop = 0xDb8d79C775452a3929b86ac5DEaB3e9d38e1c006;

    // function setUp() public {
    //     BurnAirdrop burnAirdrop = new BurnAirdrop();
    //     vm.startPrank(jailwarden);
    //     console2.log("balanceOf");
    //     console2.log(oldContract.balanceOf(jailwarden));
    //     oldContract.approve(address(burnAirdrop), 9);

    //     uint256 instanceId = 74881264; //56985840
    //     uint256[] memory amounts = new uint256[](1);
    //     amounts[0] = 1;

    //     vm.startPrank(adminOzzz);
    //     newContract.approveAdmin(adminOzzz);
    //     newContract.approveAdmin(address(burnAirdrop));
    //     burnAirdrop.burnAirdrop(instanceId, amounts, 9);

    //     console2.log("airdropped balance");
    //     console2.log(newContract.balanceOf(jailwarden, 1));
    //     vm.stopPrank();
    // }

    function run() public {
        vm.startBroadcast();

        new BurnAirdrop();

        vm.stopBroadcast();
    }
    // function run() public {
    //     // vm.startBroadcast();

    //     // setUp();

    //     // vm.stopBroadcast();
    // }
}
