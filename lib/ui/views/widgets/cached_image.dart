import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  final String imageUrl;
  final Color color;

  const CachedImage({Key key, this.imageUrl, this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      color: color??Colors.orange,
      imageUrl: imageUrl,
      progressIndicatorBuilder: (context, url, downloadProgress) => Center(
          child: CircularProgressIndicator(value: downloadProgress.progress)),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
