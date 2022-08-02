import 'dart:math';

import 'package:flutter/material.dart';
import 'package:friends/colors.dart';
import 'package:friends/widgets/friends/friends_list_tile.dart';
import 'friends_screen.dart';
import '../dashboard/dashboard_card.dart';
import 'package:friends/constants.dart' as constants;
import 'package:friends/textstyles.dart';

class FriendsCard extends StatelessWidget {
  final List friends;
  final List groups;
  final Function showFriendModal;

  const FriendsCard({
    Key? key,
    required this.friends,
    required this.groups,
    required this.showFriendModal,
  }) : super(key: key);

  List sortedFriendsByImportance() {
    List sorted = friends;

    sorted.sort((friend1, friend2) {
      return (friend1[constants.friendIntimacy]
          .compareTo(friend2[constants.friendIntimacy]));
    });

    return sorted;
  }

  Widget buildFriendsScreen(BuildContext context) {
    final friendsDocs = constants.friendsDocs;
    final groupsDocs = constants.groupsDocs;
    return FriendsScreen(
      friends: friendsDocs,
      groups: groupsDocs,
      showFriendModal: showFriendModal,
    );
  }

  @override
  Widget build(BuildContext context) {
    List sortedFriends = sortedFriendsByImportance();

    return DashboardCard(
      title: 'Friends',
      icon: const Icon(
        Icons.home,
        size: 40,
      ),
      emptyCardMessage:
          friends.isEmpty ? "No friends yet, click here to add some!" : null,
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: buildFriendsScreen,
        ),
      ),
      child: Column(
        children: [
          ListView.builder(
            padding: const EdgeInsets.only(bottom: 0),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: min(5, friends.length),
            itemBuilder: (context, int index) {
              final friend = sortedFriends[index];
              final name = friend[constants.name];
              final checkinInterval = friend[constants.checkInInterval];

              return FriendsListTile(
                name: name,
                id: friend['id'],
                checkinInterval: checkinInterval,
                groups: groups,
              );
            },
          ),
        ],
      ),
    );
  }
}
