import 'package:flutter/material.dart';
import 'package:friends/constants.dart' as constants;

class CheckinDropdownMenu extends StatefulWidget {
  final String checkinInterval;
  final Function(String?) onChanged;

  const CheckinDropdownMenu({
    Key? key,
    required this.checkinInterval,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CheckinDropdownMenu();
}

class _CheckinDropdownMenu extends State<CheckinDropdownMenu> {
  late String _checkinInterval = widget.checkinInterval;

  @override
  Widget build(BuildContext context) {
    List<String> names = constants.checkinIntervalNames;

    return DropdownButton(
      value: _checkinInterval,
      hint: const Text('Select Check In Interval'),
      items: names.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? interval) {
        setState(() {
          _checkinInterval = interval!;
          widget.onChanged(interval);
        });
      },
    );
  }
}
