import 'package:flutter/material.dart';
import 'package:friends/constants.dart' as constants;
import 'package:friends/textstyles.dart';

class FriendsListTile extends StatelessWidget {
  final String name;
  final String id;
  final String? checkinInterval;
  final void Function()? onTap;
  final Widget? trailing;
  final dynamic groups;

  const FriendsListTile({
    Key? key,
    required this.name,
    required this.id,
    this.checkinInterval,
    this.onTap,
    this.trailing,
    required this.groups,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String checkinName = '';
    String subtitle = '';

    if (checkinInterval != null && checkinInterval != 'None') {
      checkinName = checkinInterval!;
    }

    // find each group friend is in, and add to subtitle string
    for (int i = 0; i < groups.length; i++) {
      final group = groups[i];
      if (group[constants.friendIds].contains(id)) {
        subtitle += group[constants.name];
        if (i != groups.length - 1) {
          subtitle += ', ';
        }
      }
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: ListTile(
        title: Text(name, style: cardText),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(subtitle, style: paragraphText.copyWith(fontSize: 20)),
            Text(checkinName, style: paragraphText),
          ],
        ),
        trailing: trailing,
        visualDensity: const VisualDensity(
          vertical: VisualDensity.minimumDensity,
        ),
        onTap: onTap,
      ),
    );
  }
}
