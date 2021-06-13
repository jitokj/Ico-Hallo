// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";

// chainlink price feed for ETH/USD calculation

contract PriceFeed {
    AggregatorV3Interface internal priceFeed;

    /**
     * Network: Rinkeby
     * Aggregator: ETH/USD
     * Address: 0x8A753747A1Fa494EC906cE90E9f37563A8AF630e
     */
    constructor() {
        priceFeed = AggregatorV3Interface(
            0x8A753747A1Fa494EC906cE90E9f37563A8AF630e
        );
    }

    /**
     * Returns the latest price
     */
    function getThePrice() public view returns (int256) {
        (
            uint80 roundID,
            int256 price,
            uint256 startedAt,
            uint256 timeStamp,
            uint80 answeredInRound
        ) = priceFeed.latestRoundData();

        return price;
    }
}
