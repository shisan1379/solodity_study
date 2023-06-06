// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.7.0) (utils/Strings.sol)

pragma solidity ^0.8.0;

interface Solidity101 {
    function hello() external pure;

    function world(int256) external pure;
}

contract Selector {

    function calculateSelector()
        public
        returns (
            bytes4,
            bytes4,
            bytes4
        )
    {
        Solidity101 i;

        bytes4 id1 = type(Solidity101).interfaceId;
        bytes4 id2 = i.hello.selector ^ i.world.selector;

        bytes4 id3 = bytes4(keccak256("hello()")) ^
            bytes4(keccak256("world(int256)"));

        return (id1, id2, id3);
    }
}
