// SPDX-License-Identifier: GPL-3.0

//retrieveAddressesOneMonthFromToday
//retrieveAddressesTwoWeeksFromToday
//retrieveAddresses3DaysFromToday
//retrieveAddressesOverdueFor3Days
pragma solidity ^0.8.0;
import "./DateTimeContract.sol";
import "./DateTime.sol";
import "./firebase.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract notificationTests {
    FirebaseSystem public firebaseSys;

    constructor(address _firebaseSysAddress) {
        firebaseSys = FirebaseSystem(_firebaseSysAddress);
    }

    function retrieveAddressesOneMonthFromToday(uint256 _timestamp)
        public
        view
        returns (address[] memory)
    {
        return
            firebaseSys.retrieveAddress(
                0,
                timestampToDateAfterAddingOneMonth(_timestamp)
            );
    }

    function retrieveAddressesTwoWeeksFromToday(uint256 _timestamp)
        public
        view
        returns (address[] memory)
    {
        return
            firebaseSys.retrieveAddress(
                0,
                timestampToDateAfterAddingTwoWeeks(_timestamp)
            );
    }

    function retrieveAddresses3DaysFromToday(uint256 _timestamp)
        public
        view
        returns (address[] memory)
    {
        return
            firebaseSys.retrieveAddress(
                0,
                timestampToDateAfterAdding3Days(_timestamp)
            );
    }

    function retrieveAddressesFromToday(uint256 _timestamp)
        public
        view
        returns (address[] memory)
    {
        return
            firebaseSys.retrieveAddress(
                0,
                timestampToDateFromToday(_timestamp)
            );
    }

    function retrieveAddresses3DaysOverdue(uint256 _timestamp) public view returns (address[] memory) {
    string[] memory dateList = timestampToDateAfterSubtract3Days(_timestamp);
    uint256 maxNumberOfAddresses = 100;
    address[] memory addrList = new address[](3 * maxNumberOfAddresses);
    uint256 addrCounter = 0;

    for (uint256 i = 0; i < 3; i++) {
        address[] memory addrListForDate = firebaseSys.retrieveAddress(0, dateList[i]);
        for (uint256 j = 0; j < addrListForDate.length; j++) {
            addrList[addrCounter] = addrListForDate[j];
            addrCounter++;
        }
    }

    // Resize addrList to actual number of addresses
    address[] memory result = new address[](addrCounter);
    for (uint256 k = 0; k < addrCounter; k++) {
        result[k] = addrList[k];
    }

    return result;
}


    function timestampToDateAfterAddingOneMonth(uint256 _timestamp)
        public
        pure
        returns (string memory date)
    {
        uint256 year;
        uint256 month;
        uint256 day;
        (year, month, day) = DateTime.timestampToDate(_timestamp);
        if (month == 4 || month == 6 || month == 9 || month == 11) {
            day += 30;
            if (day > 30) {
                day = day % 30;
                month += 1;
            }
        } else if (month == 2) {
            day += 28;
            if (day > 28) {
                day = day % 28;
                month += 1;
            }
        } else {
            day += 31;
            if (day > 31) {
                day = day % 31;
                if (month == 12) {
                    month = 1;
                    year += 1;
                } else {
                    month += 1;
                }
            }
        }
        return formatDate(day, month);
    }
function timestampToDateFromToday(uint256 _timestamp)
        public
        pure
        returns (string memory date)
    {
        uint256 year;
        uint256 month;
        uint256 day;
        (year, month, day) = DateTime.timestampToDate(_timestamp);
        if (month == 4 || month == 6 || month == 9 || month == 11) {
            day += 1;
            if (day > 30) {
                day = day % 30;
                month += 1;
            }
        } else if (month == 2) {
            day += 1;
            if (day > 28) {
                day = day % 28;
                month += 1;
            }
        } else {
            day += 1;
            if (day > 31) {
                day = day % 31;
                if (month == 12) {
                    month = 1;
                    year += 1;
                } else {
                    month += 1;
                }
            }
        }

        return formatDate(day, month);

        }

    function timestampToDateAfterAddingTwoWeeks(uint256 _timestamp)
        public
        pure
        returns (string memory date)
    {
        uint256 year;
        uint256 month;
        uint256 day;
        (year, month, day) = DateTime.timestampToDate(_timestamp);
        if (month == 4 || month == 6 || month == 9 || month == 11) {
            day += 14;
            if (day > 30) {
                day = day % 30;
                month += 1;
            }
        } else if (month == 2) {
            day += 14;
            if (day > 28) {
                day = day % 28;
                month += 1;
            }
        } else {
            day += 14;
            if (day > 31) {
                day = day % 31;
                if (month == 12) {
                    month = 1;
                    year += 1;
                } else {
                    month += 1;
                }
            }
        }
        return formatDate(day, month);
    }

    function timestampToDateAfterAdding3Days(uint256 _timestamp)
        public
        pure
        returns (string memory date)
    {
        uint256 year;
        uint256 month;
        uint256 day;
        (year, month, day) = DateTime.timestampToDate(_timestamp);
        if (month == 4 || month == 6 || month == 9 || month == 11) {
            day += 3;
            if (day > 30) {
                day = day % 30;
                month += 1;
            }
        } else if (month == 2) {
            day += 3;
            if (day > 28) {
                day = day % 28;
                month += 1;
            }
        } else {
            day += 3;
            if (day > 31) {
                day = day % 31;
                if (month == 12) {
                    month = 1;
                    year += 1;
                } else {
                    month += 1;
                }
            }
        }
        return formatDate(day, month);
    }

    function timestampToDateAfterSubtract3Days(uint256 _timestamp)
        public
        pure
        returns (string[] memory)
    {
        uint256 year;
        uint256 month;
        uint256 day;
        uint256 i;
        string memory date;
        string[] memory dateList = new string[](3);
        (year, month, day) = DateTime.timestampToDate(_timestamp);
        date = formatDate(day, month);
        dateList[0] = date;

        for (i = 1; i < 3; i++) {
            if (month == 4 || month == 6 || month == 9 || month == 11) {
                day -= 1;
                if (day > 30) {
                    day = day % 30;
                    month += 1;
                }
            } else if (month == 2) {
                day -= 1;
                if (day > 28) {
                    day = day % 28;
                    month += 1;
                }
            } else {
                day -= 1;
                if (day > 31) {
                    day = day % 31;
                    if (month == 12) {
                        month = 1;
                        year += 1;
                    } else {
                        month += 1;
                    }
                }
            }
            date = formatDate(day, month);
            dateList[i] = date;
        }
        return dateList;
    }

    function formatDate(uint256 day, uint256 month)
        public
        pure
        returns (string memory date)
    {
        // Ensure day and month have two digits
        string memory dayStr;
        if (day < 10) {
            string memory stringday = Strings.toString(day);
            string memory stringday1 = Strings.toString(0);
            dayStr = concatenate(stringday1, stringday);
        } else {
            string memory stringday = Strings.toString(day);
            dayStr = stringday;
        }

        string memory monthStr;
        if (month < 10) {
            string memory stringMnth = Strings.toString(month);
            string memory stringMnth1 = Strings.toString(0);
            monthStr = concatenate(stringMnth1, stringMnth);
        } else {
            string memory stringMnth = Strings.toString(month);
            monthStr = stringMnth;
        }

        date = concatenate(dayStr, monthStr);
        return date;
    }

    function concatenate(string memory a, string memory b)
        public
        pure
        returns (string memory)
    {
        return string(abi.encodePacked(a, b));
    }
}
