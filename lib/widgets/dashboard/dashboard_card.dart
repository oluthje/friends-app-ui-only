import 'package:flutter/material.dart';
import 'package:friends/colors.dart';
import 'package:friends/textstyles.dart';

class DashboardCard extends StatelessWidget {
  final Widget child;
  final String title;
  final Function onPressed;
  final Icon icon;
  final String? emptyCardMessage;

  const DashboardCard({
    Key? key,
    required this.child,
    required this.title,
    required this.onPressed,
    required this.icon,
    this.emptyCardMessage,
  }) : super(key: key);

  dynamic emptyCardMessageWidget() {
    if (emptyCardMessage != null) {
      return Padding(
        padding: const EdgeInsets.only(left: 16, bottom: 16, right: 16),
        child: Text("$emptyCardMessage"),
      );
    }
    return const Padding(padding: EdgeInsets.zero);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Card(
          color: scaffoldBackground,
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, top: 0.0, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: icon,
                        ),
                        Text(
                          title,
                          style: titleText.copyWith(fontSize: 35),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () => onPressed(),
                      child: const Icon(Icons.arrow_forward_ios_outlined),
                    ),
                  ],
                ),
              ),
              child,
              emptyCardMessageWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
