import 'dart:math';
import 'package:flutter/material.dart';
import 'package:friends/widgets/groups/groups_screen.dart';
import '../dashboard/dashboard_card.dart';
import 'package:friends/constants.dart' as constants;

import 'group_list_tile.dart';

import 'package:friends/colors.dart';
import 'package:friends/textstyles.dart';

class GroupPage extends StatelessWidget {
  double opacity = 1;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 25.0,
      ),
      child: Column(
        children: [
          Container(
            height: 350,
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
                  Text("Groups", style: titleText),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                SpotifyPlaylistCard(),
                SizedBox(height: 20),
                SpotifyPlaylistCard(),
                SizedBox(height: 20),
                SpotifyPlaylistCard(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SpotifyPlaylistCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: playlistCardGrey,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      // color: playlistCardGrey,
      height: 70,
    );
  }
}

class GroupsCard extends StatelessWidget {
  final List friends;
  final List groups;

  const GroupsCard({
    Key? key,
    required this.friends,
    required this.groups,
  }) : super(key: key);

  List sortedGroupsByImportance() {
    List sorted = groups;

    sorted.sort((group1, group2) {
      return 1;
    });

    return sorted;
  }

  Widget buildGroupsScreen(BuildContext context) {
    return GroupsScreen(friends: friends, groups: groups);
  }

  @override
  Widget build(BuildContext context) {
    List valuableGroups = sortedGroupsByImportance();

    return DashboardCard(
      title: 'Groups',
      icon: const Icon(Icons.groups),
      emptyCardMessage:
          groups.isEmpty ? "No groups yet, click here to add some!" : null,
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: buildGroupsScreen,
        ),
      ),
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.only(bottom: 0),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: min(3, groups.length),
            itemBuilder: (context, int index) {
              return GroupListTile(
                name: valuableGroups[index][constants.name],
                favorited: valuableGroups[index][constants.favorited],
              );
            },
          ),
        ],
      ),
    );
  }
}
