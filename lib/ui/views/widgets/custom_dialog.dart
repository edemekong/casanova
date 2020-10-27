import 'package:casanova/ui/commons/sizes.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatefulWidget {
  final String title;
  final List<Widget> children;

  const CustomDialog({Key key, this.title, this.children}) : super(key: key);

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      titlePadding: const EdgeInsets.all(0),
      title: Padding16Vertical(
        child: Center(child: Text(widget.title)),
      ),
      children: widget.children,
    );
  }
}
