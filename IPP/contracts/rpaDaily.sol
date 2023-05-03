//SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.4.25 <0.9.0;

contract rpaDaily {
    uint number = 25;
    event Plus();
    
//notificationEmitter?
//Needs to also emit current date
//NotificationReceiver.js will listen to the date and then use that as current date, not manual written
   function Add(uint add) public {
       number = number + add;
       emit Plus();
   }
   
   function getInput() view public returns (uint) {
       return number;
   }
}