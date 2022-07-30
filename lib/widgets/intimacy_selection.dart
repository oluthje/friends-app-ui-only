import 'package:flutter/material.dart';
import 'package:friends/constants.dart' as constants;

class IntimacySelection extends StatefulWidget {
  final int intimacy;
  final Function onChange;
  final Color color;

  const IntimacySelection({
    Key? key,
    required this.intimacy,
    required this.onChange,
    required this.color,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _IntimacySelection();
}

class _IntimacySelection extends State<IntimacySelection> {
  List<bool> isSelected = [];
  late int intimacy;

  @override
  void initState() {
    intimacy = widget.intimacy;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // setup isSelected list for intimacies toggle buttons
    if (isSelected.isEmpty) {
      for (int i = 0; i < constants.numIntimacies; i++) {
        isSelected.add(widget.intimacy == i);
      }
    }

    return ToggleButtons(
      isSelected: isSelected,
      renderBorder: true,
      borderRadius: BorderRadius.circular(5.0),
      borderColor: Theme.of(context).primaryColor,
      // selectedColor: Colors.white,
      selectedBorderColor: Theme.of(context).primaryColor,
      // fillColor: Theme.of(context).primaryColor,
      children: const [
        Text('Good'),
        Text('Moderate'),
        Text('New'),
        Text('Acquaintance'),
      ],
      onPressed: (index) {
        setState(() {
          intimacy = index;
          widget.onChange(index);

          for (int buttonIndex = 0;
              buttonIndex < isSelected.length;
              buttonIndex++) {
            if (buttonIndex == index) {
              isSelected[buttonIndex] = true;
            } else {
              isSelected[buttonIndex] = false;
            }
          }
        });
      },
    );
  }
}
