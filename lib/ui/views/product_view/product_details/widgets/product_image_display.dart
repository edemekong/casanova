import 'package:casanova/ui/views/widgets/slide_dots.dart';
import 'package:flutter/material.dart';

class ImageDisplay extends StatefulWidget {
  final List imageUrls;

  const ImageDisplay({Key key, this.imageUrls}) : super(key: key);

  @override
  _ImageDisplayState createState() => _ImageDisplayState();
}

class _ImageDisplayState extends State<ImageDisplay> {
  PageController pageController;
  int pageIndex = 0;

  @override
  void initState() {
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        fit: StackFit.expand,
        children: [
          PageView.builder(
              physics: BouncingScrollPhysics(),
              onPageChanged: onPageChanged,
              itemCount: widget.imageUrls.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Image.network(
                    widget.imageUrls[index],
                    fit: BoxFit.cover,
                  ),
                );
              }),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  for (int i = 0; i < widget.imageUrls.length; i++)
                    if (i == pageIndex)
                      SlideDotsAds(true)
                    else
                      SlideDotsAds(false)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onPageChanged(int value) {
    setState(() {
      pageIndex = value;
    });
  }
}
