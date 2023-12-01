// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

import {IERC1155} from "lib/openzeppelin-contracts/contracts/token/ERC1155/IERC1155.sol";

interface IERC1155Creator is IERC1155 {
    function mintBaseExisting(address[] calldata to, uint256[] calldata tokenIds, uint256[] calldata amounts)
        external;
    function isAdmin(address account) external view returns (bool);
    function registerExtension(address extension, string calldata baseURI) external;
    function approveAdmin(address admin) external;
    function owner() external view returns (address);
}
