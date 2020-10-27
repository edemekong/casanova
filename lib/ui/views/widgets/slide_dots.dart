import 'package:flutter/material.dart';

class SlideDots extends StatelessWidget {
  final bool isActive;
  SlideDots(this.isActive);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      margin: const EdgeInsets.symmetric(horizontal: 3),
      height: isActive ? 11 : 7,
      width: isActive ? 11 : 7,
      decoration: BoxDecoration(
        color: isActive ? Colors.black : Colors.black.withOpacity(.2),
        borderRadius: BorderRadius.all(Radius.circular(90)),
      ),
    );
  }
}

class SlideDotsAds extends StatelessWidget {
  final bool isActive;
  SlideDotsAds(this.isActive);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      margin: const EdgeInsets.symmetric(horizontal: 3),
      height: isActive ? 11 : 7,
      width: isActive ? 11 : 7,
      decoration: BoxDecoration(
        color: isActive ? Colors.orange[700] : Colors.black.withOpacity(.2),
        borderRadius: BorderRadius.all(Radius.circular(90)),
      ),
    );
  }
}
