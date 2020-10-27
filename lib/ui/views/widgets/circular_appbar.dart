import 'package:flutter/material.dart';

class AppBarCircle extends StatelessWidget {
  final Widget child;
  final Color colorBlue;
  final Color colorOrange;

  AppBarCircle({this.child, this.colorBlue, this.colorOrange});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Positioned.fill(
          //           //   left: 100,
          //           //   top: -200,
          //           //   child: Container(
          //           //     height: 250,
          //           //     decoration: BoxDecoration(
          //           //         shape: BoxShape.circle,
          //           //         color: Colors.orange[200].withOpacity(.3)),
          //           //   ),
          //           // ),
          //           // Positioned.fill(
          //           //   right: 100,
          //           //   bottom: -200,
          //           //   child: Container(
          //           //     height: 250,
          //           //     decoration: BoxDecoration(
          //           //         shape: BoxShape.circle,
          //           //         color: Colors.blue[100].withOpacity(.4)),
          //           //   ),
          //           // ),
        ],
      ),
    );
  }
}

class CustomClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.quadraticBezierTo(-300, size.height * 2.0, size.width * 7, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
