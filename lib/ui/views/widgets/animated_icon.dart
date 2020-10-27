import 'package:casanova/view_models/ads_view_model.dart/ads_view_model.dart';
import 'package:flutter/material.dart';

class AnimatedIconButton extends StatefulWidget {
  const AnimatedIconButton({
    Key key,
    this.adsModel,
  }) : super(key: key);

  final AdsViewModel adsModel;

  @override
  _AnimatedIconButtonState createState() => _AnimatedIconButtonState();
}

class _AnimatedIconButtonState extends State<AnimatedIconButton>
    with SingleTickerProviderStateMixin {
  Animation<double> buttonAnimation;
  AnimationController buttonAnimationController;

  @override
  void initState() {
    super.initState();

    buttonAnimationController = AnimationController(
      duration: Duration(milliseconds: 180),
      vsync: this,
    );

    buttonAnimation = Tween(begin: 0.0, end: 100.0).animate(
      CurvedAnimation(
        curve: Curves.bounceInOut,
        parent: buttonAnimationController,
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      repeatAnimation();
    });
  }

  @override
  void dispose() {
    buttonAnimationController?.dispose();
    super.dispose();
  }

  void repeatAnimation() async {
    if (mounted) {
      await buttonAnimationController.forward();
      await buttonAnimationController.reverse();
      await buttonAnimationController.forward();
      await buttonAnimationController.reverse();
    }

    await Future.delayed(Duration(seconds: 4));

    repeatAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: buttonAnimation,
      builder: (context, child) {
        return Positioned(
          right: buttonAnimation.value / 3,
          bottom: 0,
          child: Container(
            child: child,
          ),
        );
      },
      child: IconButton(
          icon: Icon(Icons.arrow_forward,
              color: Theme.of(context).accentColor, size: 20),
          onPressed: () => widget.adsModel.onTapChangePageView(1)),
    );
  }
}
