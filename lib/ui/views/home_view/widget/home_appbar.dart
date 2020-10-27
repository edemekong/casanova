import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  final Widget child;
  final Widget title;
  final bool checkMenu;
  final Widget topHomeButton;

  HomeAppBar({this.child, this.title, this.checkMenu, this.topHomeButton});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Container(
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: SafeArea(
              child: Container(
                color: Colors.transparent,
                margin: EdgeInsets.only(
                    top: checkMenu ? height * 0.02 : height * 0.10),
                child: title,
              ),
            ),
          ),
          topHomeButton,
          Positioned.fill(
              top: checkMenu ? height * 0.15 : height * 0.20, child: child),
        ],
      ),
    );
  }
}
