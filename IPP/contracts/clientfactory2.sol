// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.25 <0.9.0;

contract PolicySmartContract2 {

   //Emitted when update function is called
   event _updatedMessages(string newMessage, string policyID, string duration, string date_of_policy, string phone, string name, string price, string dateNTimeOfTxn);

   string public message;
   string public policyID;
   string public duration;
   string public date_of_policy;
   string public phone;
   string public name;
   string public price;
   string public dateNTimeOfTxn;

   constructor(string memory newMessage, string memory _policyID, string memory _duration, string memory _date_of_policy, string memory _phone, string memory _name, string memory _price, string memory _dateNTimeOfTxn)  {
      message = newMessage;
      policyID = _policyID;
      duration = _duration;
      date_of_policy = _date_of_policy;
      phone = _phone;
      name = _name;
      price = _price;
      dateNTimeOfTxn = _dateNTimeOfTxn;
   }

   function getEmailAddress() view public returns (string memory) {
       return message;
   }

   function getpolicyID() view public returns (string memory) {
       return policyID;
   }

   function getDuration() view public returns (string memory) {
       return duration;
   }

   function getDate_of_policy() view public returns (string memory) {
       return date_of_policy;
   }

   function getPhone() view public returns (string memory) {
       return phone;
   }

   function getName() view public returns (string memory) {
       return name;
   }

   function getPrice() view public returns (string memory) {
       return price;
   }
   function getdateNTimeOfTxn() view public returns (string memory) {
       return dateNTimeOfTxn;
   }

}

contract SmartContractFactory2 {

    PolicySmartContract2 a;
    event policyID(PolicySmartContract2 a, string newMessage, string policyID, string duration, string date_of_policy, string phone, string name, string price, string dateNTimeOfTxn);

    function update(string memory newMessage, string memory _policyID, string memory _duration, string memory _date_of_policy, string memory _phone, string memory _name, string memory _price, string memory dateNTimeOfTxn) public returns(PolicySmartContract2) {
      // Create the policyID smart contract here
       a = new PolicySmartContract2(newMessage, _policyID, _duration, _date_of_policy, _phone, _name, _price, dateNTimeOfTxn);
       emit policyID(a, newMessage, _policyID, _duration, _date_of_policy, _phone, _name, _price, dateNTimeOfTxn);
       return a; 
   }
    function getClientInformation(address _address) public view returns (
        string memory _newMessage,
        string memory _policyID,
        string memory _duration,
        string memory _date_of_policy,
        string memory _phone,
        string memory _name,
        string memory _price,
        string memory _dateNTimeOfTxn
    ) {
        PolicySmartContract2 policySmartContract2 = PolicySmartContract2(_address);
        return (policySmartContract2.getEmailAddress(), policySmartContract2.getpolicyID(), policySmartContract2.getDuration(), policySmartContract2.getDate_of_policy(), policySmartContract2.getPhone(), policySmartContract2.getName(), policySmartContract2.getPrice(), policySmartContract2.getdateNTimeOfTxn());
    }

   
}
