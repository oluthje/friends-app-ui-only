import 'package:flutter/material.dart';
import 'package:friends/widgets/friends/friend_modal.dart';

import 'package:friends/constants.dart' as constants;
import 'package:friends/widgets/friends/friends_card.dart';
import 'package:friends/widgets/groups/groups_card.dart';
import 'package:friends/widgets/check_ins/check_ins_card.dart';
import 'package:friends/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Sign in App!',
        theme: darkmode
            ? ThemeData.dark().copyWith(primaryColor: primary)
            : ThemeData(
                primaryColor: primary,
                colorScheme: ColorScheme.fromSwatch().copyWith(
                  primary: primary,
                  // secondary: const Colors.yellow.shade700,
                ),
              ),
        home: const HomePage(),
      );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => const Scaffold(
        body: FriendsApp(title: 'Friends'),
      );
}

void showFriendModal(BuildContext context, String name, String id, int intimacy,
    String checkinInterval, List groups) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(25.0),
      ),
    ),
    builder: (BuildContext context) {
      return FriendModal(
        name: name,
        id: id,
        intimacy: intimacy,
        initCheckinInterval: checkinInterval,
        groups: groups,
      );
    },
  );
}

class FriendsApp extends StatefulWidget {
  final String title;

  const FriendsApp({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<FriendsApp> createState() => _FriendsApp();
}

class _FriendsApp extends State<FriendsApp> {
  @override
  Widget build(BuildContext context) {
    final friendsDocs = constants.friendsDocs;
    final groupsDocs = constants.groupsDocs;

    return Scaffold(
      backgroundColor: scaffoldBackground,
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 8.0,
          left: 8.0,
          right: 8.0,
          bottom: 25.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FriendsCard(
                friends: friendsDocs,
                groups: groupsDocs,
                showFriendModal: showFriendModal,
              ),
              GroupsCard(
                friends: friendsDocs,
                groups: groupsDocs,
              ),
              CheckInsCard(
                friends: friendsDocs,
                groups: groupsDocs,
                showFriendModal: showFriendModal,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
