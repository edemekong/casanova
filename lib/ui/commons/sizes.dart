import 'package:flutter/material.dart';

Duration duraMili400 = Duration(milliseconds: 400);

Widget sizedBoxHeight8 = const SizedBox(height: 8);
Widget sizedBoxHeight12 = const SizedBox(height: 12);
Widget sizedBoxHeight16 = const SizedBox(height: 16);
Widget sizedBoxHeight20 = const SizedBox(height: 20);
Widget sizedBoxHeight24 = const SizedBox(height: 24);

Widget sizedBoxWidth8 = const SizedBox(width: 8);
Widget sizedBoxWidth12 = const SizedBox(width: 12);
Widget sizedBoxWidth16 = const SizedBox(width: 16);
Widget sizedBoxWidth20 = const SizedBox(width: 20);
Widget sizedBoxWidth24 = const SizedBox(width: 24);

EdgeInsets paddingAll16 = const EdgeInsets.all(16);
EdgeInsets paddingAll8 = const EdgeInsets.all(16);

class PaddingAll8 extends StatelessWidget {
  final Widget child;

  PaddingAll8({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: child,
    );
  }
}

class PaddingAll16 extends StatelessWidget {
  final Widget child;

  PaddingAll16({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: child,
    );
  }
}

class Padding8Below extends StatelessWidget {
  final Widget child;

  Padding8Below({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: child,
    );
  }
}

class Padding16Below extends StatelessWidget {
  final Widget child;

  Padding16Below({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: child,
    );
  }
}

class Padding16Horizonal extends StatelessWidget {
  final Widget child;

  Padding16Horizonal({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: child,
    );
  }
}

class Padding8Horizonal extends StatelessWidget {
  final Widget child;

  Padding8Horizonal({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: child,
    );
  }
}

class Padding16Vertical extends StatelessWidget {
  final Widget child;

  Padding16Vertical({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: child,
    );
  }
}

class PaddingVertical8Horizontal16 extends StatelessWidget {
  final Widget child;

  PaddingVertical8Horizontal16({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: child,
    );
  }
}

class PaddingVertical16Horizontal8 extends StatelessWidget {
  final Widget child;

  PaddingVertical16Horizontal8({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: child,
    );
  }
}
