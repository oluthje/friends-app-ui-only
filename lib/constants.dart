// file to keep all important constants, like firebase field names

// Firebase collections
const friends = 'friends';
const groups = 'groups';

// Firebase field names
const friendIds = 'friend_ids';
const name = 'name';
const userId = 'user_id';
const friendIntimacy = 'friend_intimacy';
const favorited = 'favorited';
const checkInInterval = 'check_in_interval';
const checkInBaseDate = 'check_in_base_date';
const checkInDates = 'check_in_dates';

// Other
const numIntimacies = 4;

enum Intimacies { good, rising, newFriend, acquaintance }

const Map<String, String> intimacyNames = {
  '0': 'Good',
  '1': 'Moderate',
  '2': 'New',
  '3': 'Acquainted',
};

enum CheckinIntervals { daily, biweekly, weekly, monthly, yearly }

const List<String> checkinIntervalNames = [
  'None',
  'Daily',
  'Biweekly',
  'Weekly',
  'Monthly',
  'Yearly'
];

Map checkinIntervalDays = {
  checkinIntervalNames[0]: 0,
  checkinIntervalNames[1]: 1,
  checkinIntervalNames[2]: 3,
  checkinIntervalNames[3]: 7,
  checkinIntervalNames[4]: 30,
  checkinIntervalNames[5]: 365,
};

final friendsDocs = [
  {
    "check_in_base_date": DateTime.now(),
    "check_in_dates": [],
    "check_in_interval": "Weekly",
    "friend_intimacy": 1,
    "name": "Tommy Caldwell",
    "user_id": 1,
    "id": "1",
  },
  {
    "check_in_base_date": DateTime.now(),
    "check_in_dates": [],
    "check_in_interval": "Daily",
    "friend_intimacy": 2,
    "name": "James",
    "user_id": 1,
    "id": "2",
  },
  {
    "check_in_base_date": DateTime.now(),
    "check_in_dates": [],
    "check_in_interval": "Monthly",
    "friend_intimacy": 2,
    "name": "Jeff",
    "user_id": 1,
    "id": "3",
  },
  {
    "check_in_base_date": DateTime.now(),
    "check_in_dates": [],
    "check_in_interval": "Monthly",
    "friend_intimacy": 3,
    "name": "Ted",
    "user_id": 1,
    "id": "3",
  },
];
final groupsDocs = [
  {
    "favorited": true,
    "friend_ids": ["1", "2"],
    "name": "UCSC",
  },
  {
    "favorited": false,
    "friend_ids": ["2", "3"],
    "name": "Classmates",
  },
  {
    "favorited": true,
    "friend_ids": ["1"],
    "name": "High School",
  },
];
