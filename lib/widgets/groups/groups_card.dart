import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:friends/widgets/groups/groups_screen.dart';
import '../dashboard/dashboard_card.dart';
import 'package:friends/constants.dart' as constants;

import 'group_list_tile.dart';

import 'package:friends/colors.dart';
import 'package:friends/textstyles.dart';

class GroupPage extends StatelessWidget {
  final List friends;
  final List groups;

  GroupPage({
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

  double opacity = 1;
  @override
  Widget build(BuildContext context) {
    List valuableGroups = sortedGroupsByImportance();
    return Padding(
      padding: EdgeInsets.only(
        bottom: 25.0,
      ),
      child: Column(
        children: [
          Container(
            height: 320,
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
                  SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return Container(
                          color: Colors.green,
                          height: 100,
                        );
                      }));
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(CircleBorder()),
                      padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                      backgroundColor: MaterialStateProperty.all(
                          spotifyGreen), // <-- Button color
                      overlayColor:
                          MaterialStateProperty.resolveWith<Color?>((states) {
                        if (states.contains(MaterialState.pressed))
                          return buttonPressedGreen; // <-- Splash color
                      }),
                      elevation: MaterialStateProperty.all(10.0),
                    ),
                    child: Icon(Icons.add, size: 50),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: MediaQuery.removePadding(
              removeTop: true,
              removeBottom: false,
              context: context,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: min(3, groups.length),
                itemBuilder: (context, int index) {
                  return SpotifyPlaylistCard(
                      valuableGroups[index][constants.name],
                      valuableGroups[index][constants.favorited]);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SpotifyPlaylistCard extends StatefulWidget {
  SpotifyPlaylistCard(this.text, this.favorited);

  final text;
  bool favorited;

  @override
  State<SpotifyPlaylistCard> createState() => _SpotifyPlaylistCardState();
}

class _SpotifyPlaylistCardState extends State<SpotifyPlaylistCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: playlistCardGrey,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      height: 70,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 60),
          Text(widget.text, style: cardText),
          SizedBox(
            width: 60,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  print("update favorites in backend!");
                  widget.favorited = !widget.favorited;
                });
              },
              child: Icon(
                widget.favorited
                    ? CupertinoIcons.heart_fill
                    : CupertinoIcons.heart,
                size: 30,
                color: spotifyGreen,
              ),
            ),
          ),
        ],
      ),
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
