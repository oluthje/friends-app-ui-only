import 'package:flutter/material.dart';
import 'package:friends/data_managers/friends_manager.dart';
import 'package:friends/widgets/friends/friends_list_tile.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:friends/constants.dart' as constants;

class FriendsList extends StatelessWidget {
  final List friends;
  final List groups;
  final Function showFriendModal;

  const FriendsList({
    Key? key,
    required this.friends,
    required this.groups,
    required this.showFriendModal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GroupedListView<dynamic, String>(
        elements: friends,
        groupBy: (element) {
          int intimacy = element[constants.friendIntimacy];
          return constants.Intimacies.values[intimacy].index.toString();
        },
        groupSeparatorBuilder: (String groupValue) {
          var groupName = constants.intimacyNames[groupValue] ?? 'Unknown';
          return Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              groupName,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          );
        },
        itemBuilder: (context, dynamic element) {
          final friend = element;
          final name = friend[constants.name];
          final intimacy = friend[constants.friendIntimacy];
          final checkinInterval = friend[constants.checkInInterval];

          return Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              FriendsManager().deleteFriend(friend['id']);
            },
            child: Card(
              child: FriendsListTile(
                name: name,
                id: friend['id'],
                checkinInterval: checkinInterval,
                onTap: () => showFriendModal(
                  context,
                  name,
                  friend['id'],
                  intimacy,
                  checkinInterval,
                  groups,
                ),
                groups: groups,
              ),
            ),
          );
        },
        itemComparator: (item1, item2) =>
            item1[constants.name].compareTo(item2[constants.name]),
        groupComparator: (group1, group2) => group1.compareTo(group2),
      ),
    );
  }
}
