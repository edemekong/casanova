
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CatCards extends StatelessWidget {
  final Function onTap;
  final String title;

  final String imageUrl;

  const CatCards({
    Key key,
    @required this.color,
    @required this.onTap,
    @required this.title,
    @required this.imageUrl,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        height: 80,
        width: 80,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: CachedNetworkImageProvider(
                imageUrl,
              ),
              fit: BoxFit.cover),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              spreadRadius: 2,
              blurRadius: 10,
              color: Colors.blue[600].withOpacity(.2),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(.6),
            shape: BoxShape.circle,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AutoSizeText(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
