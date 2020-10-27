import 'package:flutter/material.dart';

class CustomAlertDialog extends StatefulWidget {
  final String title;
  final Function onTapYes;
  final String content;

  // final List<Widget> children;

  CustomAlertDialog({
    Key key,
    this.title,
    this.onTapYes,
    this.content,
  }) : super(key: key);

  @override
  _CustomAlertDialogState createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      actionsPadding: const EdgeInsets.all(0),
      title: Text(
        widget.title,
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
      ),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(widget.content),
      ),
      actions: [
        FlatButton(
            onPressed: widget.onTapYes,
            child: Text('Yes', style: TextStyle(color: Colors.black))),
        FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text('No',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.w500))),
      ],
    );
  }
}
