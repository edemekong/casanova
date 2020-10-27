import 'package:casanova/view_models/theme_view_model/theme_model.dart';
import 'package:flutter/material.dart';

class TopText extends StatelessWidget {
  const TopText({
    Key key,
    this.text,
    this.color,
    this.fontWeight,
  }) : super(key: key);

  final String text;
  final Color color;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 18,
              fontWeight: fontWeight ?? FontWeight.w600,
              color: color ?? grey800),
        ),
      ),
    );
  }
}
