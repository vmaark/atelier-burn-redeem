// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import {CreatorExtension} from "./CreatorExtension.sol";
import {IERC1155Creator} from "./IERC1155Creator.sol";
import {IERC721} from "lib/openzeppelin-contracts/contracts/token/ERC721/IERC721.sol";
import {console2} from "forge-std/Script.sol";

interface ERC721Burnable is IERC721 {
    function burn(uint256 tokenId) external;
}

contract AtelierBurnRedeemExistingExtension is CreatorExtension {
    address private core = 0x6D90aA894d7C845c248c8866aA246ac378aA15bf;
    address private burnable = 0x670EaB9e367a2f51441Fce97A4a809437ffE8181;

    mapping(uint256 => bool) public eligibleTokens;
    mapping(address => bool) public admins;

    modifier onlyAdmin() {
        console2.log(msg.sender);
        require(
            IERC1155Creator(core).isAdmin(msg.sender),
            "AtelierBurnRedeemExistingExtension: Only admins can call this function"
        );
        _;
    }

    function setEligible(uint256 tokenId, bool eligible) public onlyAdmin {
        eligibleTokens[tokenId] = eligible;
    }

    // this will only work if the extension is set as an admin on the core contract
    function burnRedeem(uint256[] calldata tokenIds, uint256[] calldata amounts, uint256 tokenIdToBurn) public {
        require(
            tokenIds.length == amounts.length && tokenIds.length == 1,
            "AtelierBurnRedeemExistingExtension: Only one token can be redeemed at a time"
        );
        require(eligibleTokens[tokenIds[0]], "AtelierBurnRedeemExistingExtension: Token is not eligible for redemption");

        ERC721Burnable(burnable).burn(tokenIdToBurn);
        address[] memory to = new address[](1);
        to[0] = msg.sender;
        IERC1155Creator(core).mintBaseExisting(to, tokenIds, amounts);
    }
}
