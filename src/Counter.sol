// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {CreatorExtension} from "lib/creator-core-solidity/contracts/extensions/CreatorExtension.sol";
import {ERC1155Creator} from "lib/creator-core-solidity/contracts/ERC1155Creator.sol";
import {IERC1155} from "lib/openzeppelin-contracts/contracts/token/ERC1155/IERC1155.sol";

contract AtelierBurnRedeemExistingExtension is CreatorExtension {
    address private core = 0x670EaB9e367a2f51441Fce97A4a809437ffE8181;
    address private burnable = 0x670EaB9e367a2f51441Fce97A4a809437ffE8181;

    function burnRedeem(uint256[] calldata tokenIds, uint256[] calldata amounts) public {
        IERC1155(burnable).safeBatchTransferFrom(msg.sender, address(0), tokenIds, amounts, "");
        ERC1155Creator(_core).mintBaseExisting(msg.sender, tokenIds, amounts);
    }
}
