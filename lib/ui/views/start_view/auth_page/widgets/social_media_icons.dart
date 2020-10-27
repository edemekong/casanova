import 'package:flutter/material.dart';
import '../../../../../view_models/theme_view_model/theme_model.dart';

class SocialMediaIcon extends StatelessWidget {
  final String iconSrc;
  final Function onPressed;
  const SocialMediaIcon({
    Key key,
    this.iconSrc,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: primaryButtonColor.withOpacity(.3),
          ),
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          iconSrc,
          height: 40,
          width: 40,
        ),
      ),
    );
  }
}
