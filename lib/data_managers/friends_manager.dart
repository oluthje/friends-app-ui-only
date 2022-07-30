import 'package:friends/constants.dart' as constants;
import 'package:friends/data_managers/data_manager.dart';
import 'package:friends/data_managers/groups_manager.dart';

class FriendsManager extends DataManager {
  final collectionPath = 'friends';

  void addFriend(String name, int intimacy, String interval,
      List selectedGroupIds, List groups) {
    return;
  }

  void editFriend(String id, String name, int intimacy, String interval,
      List selectedGroupIds, List groups) {
    return;
  }

  void deleteFriend(String id) {
    return;
  }

  void _updateFriendsGroups(String id, List selectedGroupIds, List groups) {
    return;
  }
}

// perhaps remove constants, and keep getters setters in data manager files.
// instead of friend[constants.name], do FriendsManager.getName(friend);