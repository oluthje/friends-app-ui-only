import 'package:flutter/material.dart';

class ItemSelection extends StatefulWidget {
  final List items;
  final List selectedItems;
  final double spacing;
  final Function onUpdated;
  final BorderRadius borderRadius;

  const ItemSelection({
    Key? key,
    this.spacing = 8,
    required this.borderRadius,
    required this.items,
    required this.selectedItems,
    required this.onUpdated,
  }) : super(key: key);

  @override
  State<ItemSelection> createState() => _ItemSelection();
}

class _ItemSelection extends State<ItemSelection> {
  @override
  Widget build(BuildContext context) {
    final selectedStyle = ElevatedButton.styleFrom(
      // Foreground color
      onPrimary: Theme.of(context).primaryColor,
      // Background color
      primary: Colors.white,

      shape: RoundedRectangleBorder(
        borderRadius: widget.borderRadius,
        side: BorderSide(color: Theme.of(context).primaryColor),
      ),
    );

    final unselectedStyle = ElevatedButton.styleFrom(
      // Foreground color
      onPrimary: Colors.white,
      // Background color
      primary: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: widget.borderRadius,
      ),
    );

    void toggleSelected(i) {
      if (widget.selectedItems.contains(i)) {
        setState(() {
          widget.selectedItems.remove(i);
        });
      } else {
        setState(() {
          widget.selectedItems.add(i);
        });
      }

      widget.onUpdated(widget.selectedItems);
    }

    return Wrap(
      spacing: widget.spacing,
      alignment: WrapAlignment.center,
      children: [
        for (var i = 0; i < widget.items.length; i++)
          TextButton(
              onPressed: () {
                toggleSelected(i);
              },
              style: widget.selectedItems.contains(i)
                  ? unselectedStyle
                  : selectedStyle,
              child: Text(widget.items[i]['name']))
      ],
    );
  }
}
