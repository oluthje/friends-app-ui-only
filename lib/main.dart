import 'package:flutter/material.dart';
import 'package:friends/colors.dart';
import 'package:friends/widgets/friends/friend_modal.dart';

import 'package:friends/constants.dart' as constants;
import 'package:friends/colors.dart';
import 'package:friends/widgets/friends/friends_card.dart';
import 'package:friends/widgets/groups/groups_card.dart';
import 'package:friends/widgets/check_ins/check_ins_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Sign in App!',
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
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
  int ci = 0; //current index

  @override
  Widget build(BuildContext context) {
    final friendsDocs = constants.friendsDocs;
    final groupsDocs = constants.groupsDocs;
    final screens = [
      // FriendsCard(
      //   friends: friendsDocs,
      //   groups: groupsDocs,
      //   showFriendModal: showFriendModal,
      // ),

      GroupsCard(
        friends: friendsDocs,
        groups: groupsDocs,
      ),
      GroupPage(
        friends: friendsDocs,
        groups: groupsDocs,
      ),
      CheckInsCard(
        friends: friendsDocs,
        groups: groupsDocs,
        showFriendModal: showFriendModal,
      ),
    ];

    return Scaffold(
      backgroundColor: scaffoldBackground,
      body: screens[ci],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: bottomTabBarBackground,
        selectedFontSize: 14,
        unselectedFontSize: 10,
        selectedIconTheme: IconThemeData(
          color: brightWhite,
          size: 40,
        ),
        unselectedIconTheme: IconThemeData(
          color: fadedWhite,
          size: 37,
        ),
        currentIndex:
            ci, // increment to make it start on another page when you load app
        onTap: (index) {
          print('new index! $index');
          setState(() {
            ci = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Friends",
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: "Groups",
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            label: "Check Ins",
            backgroundColor: Colors.purple,
          ),
        ],
      ),
    );
  }
}
