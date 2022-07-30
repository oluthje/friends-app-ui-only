import 'package:friends/constants.dart' as constants;
import 'package:friends/data_managers/data_manager.dart';

class GroupsManager extends DataManager {
  final collectionPath = 'groups';

  void addGroup(String name, List friendIDs) {
    return;
  }

  void editGroup(String id, String name, List selectedFriends, bool favorited) {
    return;
  }

  // add friend if possible
  void addFriendToGroup(String groupId, String friendId) {
    return;
  }

  // remove friend if possible
  void removeFriendFromGroup(String groupId, String friendId) {
    return;
  }

  void deleteGroup(String id) {
    return;
  }
}
