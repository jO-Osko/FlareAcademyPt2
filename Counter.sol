pragma solidity ^0.8.26;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

import {TestFtsoV2Interface} from "@flarenetwork/flare-periphery-contracts/coston2/TestFtsoV2Interface.sol";
import {ContractRegistry} from "@flarenetwork/flare-periphery-contracts/coston2/ContractRegistry.sol";


contract MyToken is ERC20 {
    constructor() ERC20("My Awesome token with Flare", "MATOK"){
        _mint(msg.sender, 123 ether);
    }

    function buy() payable public {
        (uint256 feedValue, uint64 timestamp) = ContractRegistry.getTestFtsoV2().
           getFeedByIdInWei(0x01464c522f55534400000000000000000000000000);


        _mint(msg.sender, msg.value * feedValue / 10**18);
    }

}

contract MyTokenMintable is ERC20 {
   constructor(string memory name) ERC20(name, "ATK") {
       _mint(msg.sender, 1337 ether);
   }


   function mintTokens() public payable {
       _mint(msg.sender, msg.value);
   }
}


contract FTSOFeedViewer {
   function getFeedPrice(bytes21 feedId) external view returns (uint256, int8, uint64) {
       (uint256 feedValue, int8 decimals, uint64 timestamp) = ContractRegistry.getTestFtsoV2().getFeedById(feedId);


       return (feedValue, decimals, timestamp);
   }


   function getFeedPriceInWei(bytes21 feedId) external view returns (uint256, uint64) {
       (uint256 feedValue, uint64 timestamp) = ContractRegistry.getTestFtsoV2().
           getFeedByIdInWei(feedId);
       return (feedValue, timestamp);
  
   }
}


contract MyCounter {

    uint256 public count = 123;

    function increment() public {
        count = count + 1;
    }

    function decrement() public {
        count = count - 12;
    }

}