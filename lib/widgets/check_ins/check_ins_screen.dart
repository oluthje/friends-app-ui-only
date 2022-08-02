import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:friends/colors.dart';

import 'package:friends/constants.dart' as constants;
import 'package:friends/data_managers/check_in_manager.dart';
import 'package:friends/widgets/check_ins/check_in_list_tile.dart';

class CheckInsScreen extends StatefulWidget {
  final List<dynamic> friends;
  final Function showFriendModal;
  final dynamic groups;

  const CheckInsScreen({
    Key? key,
    required this.friends,
    required this.showFriendModal,
    required this.groups,
  }) : super(key: key);

  @override
  State<CheckInsScreen> createState() => _CheckInsScreen();
}

class _CheckInsScreen extends State<CheckInsScreen> {
  final db = CheckInManager();
  final textFieldController = TextEditingController();
  bool visible = true;

  dynamic noFriendsWarning(noFriends) {
    if (noFriends) {
      return const Padding(
        padding: EdgeInsets.only(top: 16),
        child: Text('No friends yet, click the button below to add some!'),
      );
    }
    return const Padding(padding: EdgeInsets.zero);
  }

  int getCheckinImportance(checkinInteral) {
    var importance = constants.checkinIntervalNames.indexOf(checkinInteral);
    if (importance == 0) return 100;
    return importance;
  }

  bool hasCheckIn(friend) {
    return false;
  }

  List sortedFriendsByCheckins() {
    List sorted = widget.friends;

    // sorted.removeWhere((element) => !hasCheckIn(element));

    sorted.sort((friend1, friend2) {
      return 1;
    });

    return sorted;
  }

  @override
  Widget build(BuildContext context) {
    final sortedFriends = sortedFriendsByCheckins();

    return Scaffold(
      backgroundColor: scaffoldBackground,
      appBar: AppBar(title: const Text('Check Ins')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          noFriendsWarning(widget.friends.isEmpty),
          NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              final ScrollDirection direction = notification.direction;
              setState(() {
                if (direction == ScrollDirection.reverse) {
                  visible = false;
                } else if (direction == ScrollDirection.forward) {
                  visible = true;
                }
              });
              return true;
            },
            child: Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemBuilder: (BuildContext context, index) {
                    final friend = sortedFriends[index];
                    final name = friend[constants.name];
                    final intimacy = friend[constants.friendIntimacy];
                    final checkInInterval = friend[constants.checkInInterval];

                    return Card(
                      child: CheckInListTile(
                        friend: friend,
                        onTap: () => widget.showFriendModal(
                          context,
                          name,
                          friend['id'],
                          intimacy,
                          checkInInterval,
                          widget.groups,
                        ),
                      ),
                    );
                  },
                  itemCount: sortedFriends.length,
                ),
              ),
            ),
          ),
        ],
      ),
      // floatingActionButton: AnimatedContainer(
      //   duration: const Duration(milliseconds: 250),
      //   curve: Curves.fastOutSlowIn,
      //   transform: Matrix4.translationValues(0, visible ? 0 : 110, 0),
      //   child: FloatingActionButton(
      //     backgroundColor: Colors.blue,
      //     onPressed: () => showFriendModal(
      //       context,
      //       '',
      //       '',
      //       constants.Intimacies.newFriend.index,
      //       constants.checkinIntervalNames[0],
      //     ),
      //     child: const Icon(Icons.add),
      //   ),
      // ),
    );
  }
}
