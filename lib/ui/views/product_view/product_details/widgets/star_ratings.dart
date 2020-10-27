
import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final int star;

  const RatingStars({
    Key key,
    this.star,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            Row(
              children: List.generate(
                  5,
                      (index) => Icon(
                    Icons.star,
                    size: 15,
                    color: Colors.grey,
                  )),
            ),
            Row(
              children: List.generate(
                  star,
                      (index) => Icon(
                    Icons.star,
                    size: 15,
                    color: Colors.orange,
                  )),
            ),
          ],
        ),
        Text('  $star.0'),
      ],
    );
  }
}