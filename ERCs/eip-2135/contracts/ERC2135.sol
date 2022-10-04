// SPDX-License-Identifier: Apache-2.0
// Author: Zainan Victor Zhou <zzn-ercref@zzn.im>

pragma solidity ^0.8.9;

import "@openzeppelin/contracts/utils/introspection/ERC165.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "./IERC2135.sol";

abstract contract AERC2135 is IEIP2135, ERC165 {
    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(ERC165)
        returns (bool)
    {
        return
            interfaceId == type(IEIP2135).interfaceId ||
            super.supportsInterface(interfaceId);
    }
}

contract ERC2135Ext721Impl is IEIP2135, ERC165, ERC721 {
    event ErcRefImplDeploy(uint256 version, string name, string url);

    constructor(uint256 _version)
        ERC721("ERC2135Ext721Impl", "ERC2135Ext721Impl")
    {
        emit ErcRefImplDeploy(
            _version,
            "ERC2135Ext721Impl",
            "http://zzn.li/ercref"
        );
    }

    function consume(
        address _consumer,
        uint256 _assetId,
        uint256 _amount,
        bytes calldata _data
    ) external returns (bool _success) {
        require(_amount == 1);
        emit OnConsumption(_consumer, _assetId, _amount, _data);
        _burn(_assetId);
    }

    function isConsumableBy(
        address _consumer,
        uint256 _assetId,
        uint256 _amount
    ) external view returns (bool _consumable) {
        require(_amount == 1);
        return ownerOf(_assetId) == _consumer;
    }

    // The following functions are overrides required by Solidity.
    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC165)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
