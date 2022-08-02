import 'package:flutter/material.dart';
import 'package:friends/colors.dart';

class DashboardCard extends StatelessWidget {
  final Widget child;
  final String title;
  final Function onPressed;
  final IconData icon;
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
    return Card(
      color: dashboardCardBackground,
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
        onTap: () => onPressed(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Icon(icon, color: iconColor),
                      ),
                      Text(
                        title,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: headingColor),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () => onPressed(),
                    child: const Icon(Icons.arrow_forward_ios_outlined,
                        color: iconColor),
                  ),
                ],
              ),
            ),
            child,
            emptyCardMessageWidget(),
          ],
        ),
      ),
    );
  }
}
