import 'package:flutter/material.dart';
import '../../../../../ui/commons/sizes.dart';

class LogoWithTitleAndSubtitle extends StatelessWidget {
  final imageUrl;
  final String title;
  final String subtitle;

  final double imageSize;
  final double subtitleFontSize;

  final Widget widget;

  final String authNum;

  const LogoWithTitleAndSubtitle({
    Key key,
    this.imageUrl,
    @required this.title,
    @required this.subtitle,
    this.imageSize,
    this.widget,
    this.subtitleFontSize,
    this.authNum,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        imageUrl == null
            ? SizedBox(height: 0)
            : Container(
                height: imageSize ?? 130,
                padding: paddingAll8,
                child: imageUrl,
              ),
        widget ?? Container(),
        Text(
          '$title',
          style: TextStyle(
              color: Colors.grey[800],
              fontSize: 25,
              fontWeight: FontWeight.w800),
        ),
        SizedBox(height: 10),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(children: [
            TextSpan(
              text: '$subtitle',
              style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: subtitleFontSize ?? 14,
                  fontWeight: FontWeight.w400),
            ),
            TextSpan(
              text: '${authNum == null ? '' : authNum}',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: subtitleFontSize ?? 14,
                  fontWeight: FontWeight.w600),
            ),
          ]),
        ),
      ],
    );
  }
}
