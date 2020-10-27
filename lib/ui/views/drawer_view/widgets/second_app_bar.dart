import 'package:casanova/ui/commons/sizes.dart';
import 'package:casanova/view_models/theme_view_model/theme_model.dart';
import 'package:flutter/material.dart';

class SecondAppBar extends StatelessWidget {
  final String leadingText;
  final String trailingText;
  bool isTrailingWid;
  final Widget child;

  SecondAppBar({
    Key key,
    @required this.isTrailingWid,
    this.child,
    this.leadingText,
    this.trailingText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
        color: Colors.yellow,
        height: 50,
        width: screenSize.width,
        padding: paddingAll16,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(leadingText == null ? '' : leadingText,
                style: TextStyle(fontWeight: FontWeight.w600)),
            isTrailingWid
                ? child
                : Text(trailingText == null ? '' : trailingText,
                    style: TextStyle(color: grey600)),
          ],
        ));
  }
}
