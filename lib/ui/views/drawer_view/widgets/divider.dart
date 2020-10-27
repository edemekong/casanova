import 'package:casanova/view_models/theme_view_model/theme_model.dart';
import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final double width;
  final Color color;
  const CustomDivider({
    Key key,
    this.width,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color == null ? grey400 : color,
      height: 0.5,
      width: width,
    );
  }
}
