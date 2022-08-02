import 'package:flutter/material.dart';
import 'package:friends/colors.dart';
import 'package:friends/textstyles.dart';

class GroupEditingScreen extends StatelessWidget {
  final names = [
    "Matthew",
    "Louis",
    "Adam",
    "Jonah",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: scaffoldBackground,
        elevation: 0,
        title: Text("New Group", style: titleText.copyWith(fontSize: 25)),
      ),
      backgroundColor: scaffoldBackground,
      body: Column(
        children: [
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            child: Icon(Icons.edit, color: scaffoldBackground, size: 50),
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              padding: EdgeInsets.all(20),
              primary: Colors.white, // <-- Button color
              onPrimary: Colors.grey, // <-- Splash color
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Jonathan", style: paragraphText.copyWith(fontSize: 25)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Jakob", style: paragraphText.copyWith(fontSize: 25)),
              ],
            ),
          ),
          Divider(height: 20, thickness: 5),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 400),
            child: ListView.builder(
                itemCount: names.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(names[index],
                            style: paragraphText.copyWith(fontSize: 25)),
                        Icon(Icons.person_add, size: 30),
                      ],
                    ),
                  );
                }),
          ),
          SizedBox(height: 50),
          Text("bottom navigation bar would be here", style: paragraphText),
        ],
      ),
    );
  }
}
