// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract AddMonth {
    function addOneMonth(uint256 _timestamp) public pure returns (uint256) {
        uint256 year = 1970 + _timestamp / (365 * 24 * 60 * 60);
        uint256 dayOfYear = (_timestamp % (365 * 24 * 60 * 60)) / (24 * 60 * 60) + 1;
        uint256 month = 1;

        // Check for leap year
        if (isLeapYear(year) && dayOfYear > 31 + 29) {
            dayOfYear -= 29;
        } else if (!isLeapYear(year) && dayOfYear > 31 + 28) {
            dayOfYear -= 28;
        }

        while (month <= 12 && dayOfYear > daysInMonth(month, year)) {
            dayOfYear -= daysInMonth(month, year);
            month++;
        }

        // Check if the resulting month has fewer days than the original day
        if (dayOfYear > daysInMonth(month, year)) {
            dayOfYear = daysInMonth(month, year);
        }

        // Increment the month and adjust the year if necessary
        if (month == 12) {
            month = 1;
            year++;
        } else {
            month = month + 1;
        }
        return toTimestamp(year, month+1, dayOfYear);
    }

    function isLeapYear(uint256 year) private pure returns (bool) {
        return year % 4 == 0 && (year % 100 != 0 || year % 400 == 0);
    }

    function daysInMonth(uint256 month, uint256 year) private pure returns (uint256) {
        if (month == 2) {
            return isLeapYear(year) ? 29 : 28;
        } else if (month == 4 || month == 6 || month == 9 || month == 11) {
            return 30;
        } else {
            return 31;
        }
    }

    function toTimestamp(uint256 year, uint256 month, uint256 dayOfMonth) private pure returns (uint256) {
        uint256 dayOfYear = 0;

        for (uint256 i = 0; i < month; i++) {
            if (i == 1){
                month -= 1;
            }
            dayOfYear += daysInMonth(i, year);
        }
        dayOfYear += dayOfMonth - 1;

        return (year - 1970) * 365 * 24 * 60 * 60 + dayOfYear * 24 * 60 * 60;
    }
}
