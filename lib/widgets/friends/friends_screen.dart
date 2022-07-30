import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:friends/constants.dart' as constants;
import 'package:friends/widgets/friends/friends_list.dart';

class FriendsScreen extends StatefulWidget {
  final List friends;
  final List groups;
  final Function showFriendModal;

  const FriendsScreen({
    Key? key,
    required this.friends,
    required this.groups,
    required this.showFriendModal,
  }) : super(key: key);

  @override
  State<FriendsScreen> createState() => _FriendsScreen();
}

class _FriendsScreen extends State<FriendsScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Friends')),
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
              child: FriendsList(
                friends: widget.friends,
                groups: widget.groups,
                showFriendModal: widget.showFriendModal,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.fastOutSlowIn,
        transform: Matrix4.translationValues(0, visible ? 0 : 110, 0),
        child: FloatingActionButton(
          onPressed: () => widget.showFriendModal(
            context,
            '',
            '',
            constants.Intimacies.newFriend.index,
            constants.checkinIntervalNames[0],
            widget.groups,
          ),
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
