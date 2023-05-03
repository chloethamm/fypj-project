// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.4.25 <0.9.0;

contract FirebaseSystem{
    // payment status key => value ( date key => address value)
    // payment status 0 = unpaid, 1 = paid, 2 = overdue
    mapping (uint => mapping (string => address[])) addressLookUpByPaymentStatus;


    function storeAddressByPaymentStatus(uint _paymentStatus, string memory _date, address _addr) public{
        addressLookUpByPaymentStatus[_paymentStatus][_date].push(_addr);
    }


    function retrieveAddress(uint _paymentStatus, string calldata _date) external view returns(address[] memory){
        address[] memory tempList = new address[](addressLookUpByPaymentStatus[_paymentStatus][_date].length);
        for (uint i = 0; i < addressLookUpByPaymentStatus[_paymentStatus][_date].length; i++){
            tempList[i] = addressLookUpByPaymentStatus[_paymentStatus][_date][i];
        }
        return tempList;
    }

    function removeAddressToChangeAddress(uint _oldStatus, string memory _date, address _addr) public{
        for (uint i = 0; i < addressLookUpByPaymentStatus[_oldStatus][_date].length; i++){
            if (_addr == addressLookUpByPaymentStatus[_oldStatus][_date][i]){
                delete addressLookUpByPaymentStatus[_oldStatus][_date][i];
            }
        }

    }
    function checkForSpecificAddress(uint _paymentStatus, string memory _date, address _addr) public view returns (address) {
    for (uint i = 0; i < addressLookUpByPaymentStatus[_paymentStatus][_date].length; i++) {
        if (_addr == addressLookUpByPaymentStatus[_paymentStatus][_date][i]) {
            return _addr;
        }
    }
    return address(0);
}


    // constructor(){
    //     storeAddressByPaymentStatus(1, "0712", 0x70Eda919278179BA6E546F7EDeaf2383cE41cC4e);
    //     storeAddressByPaymentStatus(1, "0712", 0xF093C5A67aa483923Ff5AA96D16fCa851F16392D);
    //     storeAddressByPaymentStatus(1, "0812", 0xF093C5A67aa483923Ff5AA96D16fCa851F16392D);
    //     storeAddressByPaymentStatus(1, "0812", 0xF093C5A67aa483923Ff5AA96D16fCa851F16392D);
    // }
}