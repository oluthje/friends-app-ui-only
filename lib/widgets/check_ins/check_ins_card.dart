import 'package:flutter/material.dart';
import '../check_ins/check_ins_screen.dart';
import '../dashboard/dashboard_card.dart';
import 'package:friends/constants.dart' as constants;

import 'check_in_list_tile.dart';

class CheckInsCard extends StatelessWidget {
  final List friends;
  final List groups;
  final Function showFriendModal;

  const CheckInsCard({
    Key? key,
    required this.friends,
    required this.groups,
    required this.showFriendModal,
  }) : super(key: key);

  int getCheckinImportance(checkinInterval) {
    var importance = constants.checkinIntervalNames.indexOf(checkinInterval);
    if (importance == 0) return 100;
    return importance;
  }

  // Sort friends by how often their check in is.
  List sortedFriendsByCheckins() {
    List sorted = friends
        .where((friend) =>
            friend[constants.checkInInterval] !=
            constants.checkinIntervalNames[0])
        .toList();

    sorted.sort((friend1, friend2) {
      return 1;
    });

    return sorted;
  }

  Widget buildCheckInsScreen(BuildContext context) {
    return CheckInsScreen(
      friends: friends,
      showFriendModal: showFriendModal,
      groups: groups,
    );
  }

  @override
  Widget build(BuildContext context) {
    List sortedFriends = sortedFriendsByCheckins();

    return DashboardCard(
      title: 'Check Ins',
      icon: Icons.check,
      emptyCardMessage:
          friends.isEmpty ? "No checkins yet, click here to add some!" : null,
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: buildCheckInsScreen,
        ),
      ),
      child: Column(
        children: [
          ListView.builder(
            padding: const EdgeInsets.only(bottom: 0),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: sortedFriends.length.clamp(0, 3),
            itemBuilder: (context, int index) {
              final friend = sortedFriends[index];
              return CheckInListTile(
                friend: friend,
                onTap: () => showFriendModal,
              );
            },
          ),
        ],
      ),
    );
  }
}
