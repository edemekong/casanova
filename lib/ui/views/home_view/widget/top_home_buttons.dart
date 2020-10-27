import 'package:casanova/ui/views/home_view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TopHomeButtons extends StatelessWidget {
  const TopHomeButtons({
    Key key,
    @required this.imageUrl,
  }) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Tooltip(
                    message: 'Menu',
                    child: InkWell(
                      onTap: () =>
                          HomeView.scaffoldkey.currentState.openDrawer(),
                      child: CircleAvatar(
                        backgroundColor: Colors.orange,
                        radius: 18,
                        child: CircleAvatar(
                            radius: 17,
                            backgroundImage:
                                CachedNetworkImageProvider(imageUrl)),
                      ),
                    ),
                  ),
                ),
                Tooltip(
                  message: '',
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AnimatedRotatedIcon(
                      icon: Icons.search,
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

class AnimatedRotatedIcon extends StatefulWidget {
  final IconData icon;
  const AnimatedRotatedIcon({
    Key key,
    this.icon,
  }) : super(key: key);

  @override
  _AnimatedRotatedIconState createState() => _AnimatedRotatedIconState();
}

class _AnimatedRotatedIconState extends State<AnimatedRotatedIcon>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  CurvedAnimation _curveAnimation;
  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _curveAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 400),
            child: Transform.rotate(
              angle: -_curveAnimation.value * 6.3,
              child: GestureDetector(
                onTap: () {
                  _controller.reset();

                  if (_controller.isAnimating) {
                    _controller.stop();
                  } else {
                    // _controller.repeat();
                    _controller.forward();
                  }
                },
                child: Icon(
                  widget.icon,
                ),
              ),
            ),
          );
        });
  }
}
