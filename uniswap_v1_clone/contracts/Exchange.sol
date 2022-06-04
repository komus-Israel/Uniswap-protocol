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

        require(_tokenAddress != address(0), "token can't be zero address");
        tokenAddress = _tokenAddress;

    }


    function getTokenAddress () external view returns (address) {

        return tokenAddress;

    }

    /**
        *   @dev    function to add liquidity to the exchange contract.

            Ether and token is deposited to the contract to provide liquidity   
     */

    function addLiquidity(uint256 _tokenAmount) external payable {

        IERC20(tokenAddress).transferFrom(msg.sender, address(this), _tokenAmount);

    }


    /**
        @dev    function to get the quantity of token reserve in the exchange contract
     */

    function getReserve() external view returns (uint256) {

        return IERC20(tokenAddress).balanceOf(address(this));

    }

    /**
        @dev function to get the amount of tokens to get in exchange for trading a token. It is the output amount
        This amount is calculated using the AMM model
    */

    function getAmount(uint256 _inputAmount, uint256 _inputReserve, uint256 _outputReserve) internal pure returns (uint256) {

        require((_inputReserve != 0 && _outputReserve != 0), "invalid reserve");
        return ((_outputReserve * _inputAmount) / (_inputReserve + _inputAmount));

    }

    function getEtherAmount(uint256 _inputTokenAmount) external view returns (uint256) {
        
        uint256 tokenReserve = getReserve();
        return getAmount(_inputTokenAmount, tokenReserve, address(this).balance);

    }

    function getTokenAmount(uint256 _inputEtherAmount) external view returns (uint256) {
        


    }



}