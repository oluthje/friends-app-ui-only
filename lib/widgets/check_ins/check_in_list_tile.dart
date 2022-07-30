import 'package:flutter/material.dart';
import 'package:friends/check_in/check_in.dart';
import 'package:friends/constants.dart' as constants;
import 'package:friends/data_managers/check_in_manager.dart';

class CheckInListTile extends StatelessWidget {
  final dynamic friend;
  final void Function()? onTap;

  const CheckInListTile({
    Key? key,
    required this.friend,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final db = CheckInManager();
    final calc = CheckInCalculator();
    final name = friend[constants.name];
    final baseDate = friend[constants.checkInBaseDate];
    List<dynamic> dates = [];
    final lastCheckIn = dates.isEmpty ? null : dates.last.toDate();
    final interval = friend[constants.checkInInterval];
    final checkedIn = false; //calc.isCheckedIn(baseDate, dates, interval);
    final DateTime deadline =
        DateTime.now(); //calc.deadline(baseDate, [], interval);

    final String formattedTimeToDeadline =
        calc.formatTimeUntilDeadline(deadline);
    final String formattedTimeSinceLastCheckIn = lastCheckIn != null
        ? 'Checked in ${calc.formatTimeUntilDeadline(lastCheckIn)} ago'
        : 'No check ins yet';

    return ListTile(
      title: Text(name),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(formattedTimeSinceLastCheckIn),
        ],
      ),
      trailing: Column(
        children: [
          TextButton(
            onPressed: () {
              if (checkedIn) {
                db.removeCheckInDate(friend['id'], dates.last);
              } else {
                db.addCheckInDate(friend['id'], DateTime.now());
              }
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              alignment: Alignment.center,
            ),
            child: Icon(
              checkedIn ? Icons.check_box : Icons.check_box_outline_blank,
            ),
          ),
          Text('$formattedTimeToDeadline left'),
        ],
      ),
      onTap: onTap,
    );
  }
}
