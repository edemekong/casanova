import 'package:flutter/material.dart';

class CardWid extends StatelessWidget {
  final double height;
  final Widget child;
  final Color color;

  CardWid({Key key, this.height, this.child, this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 10),
        child: Material(
            borderRadius: BorderRadius.circular(10),
            elevation: 2.0,
            shadowColor: Colors.grey,
            child: IntrinsicHeight(
              child: Container(
                padding: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: color,
                ),
                // height: height == null ? 110 : height,
                child: child,
              ),
            )));
  }
}
