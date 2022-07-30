import 'package:friends/constants.dart' as constants;

/*
Calculates:

Calculates isCheckedIn:
  check_in_base_date, check_in_dates and check_in_deadlines => to calculate
  if friend has been checked in with.
 
*/

class CheckInCalculator {
  /*
  Deadline is calculated by:
  days = ceiling(daysFromBasedate / daysInInterval) * daysInInterval
  deadline = baseDate + days
  */
  DateTime deadline(DateTime baseDate, List dates, String interval) {
    int daysInInterval = constants.checkinIntervalDays[interval];

    int daysFromBasedate = DateTime.now().difference(baseDate).inDays;

    int days =
        (daysFromBasedate / Duration(days: daysInInterval).inDays).ceil();
    if (days == 0) {
      days = 1;
    }
    days = days * daysInInterval;

    return baseDate.add(Duration(days: days));
  }

  bool isCheckedIn(DateTime baseDate, List dates, String interval) {
    if (dates.isEmpty) return false;

    DateTime latestCheckIn = _latestDate(dates);
    DateTime checkInDeadline = deadline(baseDate, dates, interval);
    DateTime checkInStartDate = checkInDeadline
        .subtract(Duration(days: constants.checkinIntervalDays[interval]));

    // If latestCheckIn is between checkInStartDate and checkInDeadline,
    // then return true. Else return false

    final checkedIn = latestCheckIn.isAfter(checkInStartDate) &&
            latestCheckIn.isBefore(checkInDeadline) ||
        latestCheckIn == checkInDeadline;

    return checkedIn;
  }

  // returns formatted time until deadline, 5 days, 2 months, etc
  String formatTimeUntilDeadline(DateTime deadline) {
    final Duration diff = deadline.difference(DateTime.now()).abs();

    if (diff.inDays != 0) {
      int days = diff.inDays;
      if (days < 7) {
        return '$days Days';
      } else if (days < 30) {
        return '${(days / 7).floor()} Weeks';
      } else if (days < 365) {
        return '${(days / 30).floor()} Months';
      } else {
        return '${(days / 365).floor()} Years';
      }
    } else if (diff.inHours != 0) {
      return '${diff.inHours} Hours';
    } else if (diff.inMinutes != 0) {
      return '${diff.inMinutes} Minutes';
    } else if (diff.inSeconds != 0) {
      return '${diff.inSeconds} Seconds';
    }

    return '${deadline.difference(DateTime.now()).inDays} Days';
  }

  // finds difference in duration between two dates
  Duration _dateDiff(DateTime date1, DateTime date2) {
    return date1.difference(date2);
  }

  // find latest_date from dates
  DateTime _latestDate(List dates) {
    DateTime now = DateTime.now();
    DateTime latest = dates[0];

    for (DateTime date in dates) {
      if (_dateDiff(now, date) < _dateDiff(now, latest)) {
        latest = date;
      }
    }

    return latest;
  }
}

// Step 1: friend adds a check in
//  friend now has a check_in dict, with base_date, interval and dates

// How to calculate check in deadline.
// (deadline is days from today) deadline = base_date + interval days



// base date = 0
// interval = 4
// today = 27

// deadline = (today - basedate) / interval