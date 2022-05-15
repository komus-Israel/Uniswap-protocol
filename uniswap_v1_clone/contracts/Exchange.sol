pragma solidity 0.8.10;
import "./utils/IERC20.sol";

/// @title  Exchange

/**
    *   @dev    an exchange contract to be deployed for each token pair. e.g ETH/DAI
    The factory contract will keep track of every deployed exchange contract.

    *   This exchange contract will illustrate the uniswap v1 clone. So the swap will
        strictly be between an ERC20 token and Ether

    *   The token address for the exchange will be initailized in the constructor
*/


contract Exchange {

    address private tokenAddress;

    constructor (address _tokenAddress) {

        tokenAddress = _tokenAddress;

    }


    function getTokenAddress () external view returns (address) {

        return tokenAddress;

    }

}