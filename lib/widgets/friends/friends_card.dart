import 'dart:math';

import 'package:flutter/material.dart';
import 'package:friends/colors.dart';
import 'package:friends/widgets/friends/friends_list_tile.dart';
import 'friends_screen.dart';
import '../dashboard/dashboard_card.dart';
import 'package:friends/constants.dart' as constants;
import 'package:friends/textstyles.dart';

class FriendsPage extends StatelessWidget {
  double opacity = 1;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 25.0,
      ),
      child: Container(
        height: 400,
        width: double.infinity,
        decoration: BoxDecoration(
          // Box decoration takes a gradient
          gradient: LinearGradient(
            // Where the linear gradient begins and ends
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 1],
            colors: [
              Color(0xFF20713e).withOpacity(opacity),
              Color(0xFF216639).withOpacity(opacity),
              Color(0xFF215a34).withOpacity(opacity),
              Color(0xFF204f2f).withOpacity(opacity),
              Color(0xFF1f442a).withOpacity(opacity),
              Color(0xFF1e3a25).withOpacity(opacity),
              Color(0xFF1c3021).withOpacity(opacity),
              Color(0xFF19261c).withOpacity(opacity),
              Color(0xFF161c17).withOpacity(opacity),
              Color(0xFF121212).withOpacity(opacity),
              // scaffoldBackground,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100),
              Text("Friends", style: titleText),
            ],
          ),
        ),
      ),
    );
  }
}

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
      icon: const Icon(Icons.home),
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
