import 'package:flutter/material.dart';
import 'form_title.dart';

class ModalAddItem extends StatefulWidget {
  final String name;
  final String? title;
  final Function(String) onSubmit;
  final Widget? child;

  const ModalAddItem({
    Key? key,
    this.title,
    required this.name,
    required this.onSubmit,
    this.child,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ModalAddItem();
}

class _ModalAddItem extends State<ModalAddItem> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _name;

  void _trySubmit(context) {
    if (_formKey.currentState!.validate()) {
      widget.onSubmit(_name);
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    _name = widget.name;
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSize = MediaQuery.of(context).viewInsets.bottom;
    final double bottomPadding = keyboardSize < 25 ? 25 : keyboardSize;

    final formTitle = widget.title != null
        ? FormTitle(
            text: widget.title!,
          )
        : Container();

    return Wrap(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: 25.0,
            right: 25.0,
            top: 25.0,
            bottom: bottomPadding,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                formTitle,
                TextFormField(
                  initialValue: _name,
                  textCapitalization: TextCapitalization.sentences,
                  autofocus: true,
                  onEditingComplete: () => _trySubmit(context),
                  onChanged: (name) => setState(() {
                    _name = name;
                  }),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter a complete name';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                ),
                widget.child ?? Container(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      child: const Text('Cancel'),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 5),
                    ElevatedButton(
                      child: const Text('Submit'),
                      onPressed: () => _trySubmit(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
