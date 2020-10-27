import 'package:casanova/model/product/product.dart';
import 'package:casanova/ui/views/product_view/product_details/widgets/star_ratings.dart';
import 'package:flutter/material.dart';

class ProductActions extends StatelessWidget {
  final Product product;

  const ProductActions({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(8),
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${product.title}',
                  style: TextStyle(fontSize: 18),
                ),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: 'Category:  ',
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                    ),
                    TextSpan(
                      text: '${product.category}',
                      style: TextStyle(
                          fontSize: 11,
                          color: Colors.orange,
                          fontWeight: FontWeight.w300),
                    ),
                  ]),
                ),
                SizedBox(height: 10),
                Text('₦${product.price}',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                RatingStars(star: 5),
                Text(
                  '49 Reviews',
                  style: TextStyle(
                      color: Colors.blue, decoration: TextDecoration.underline),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              FavoriteHeart(),
              FlatButton.icon(
                color: Colors.orange,
                onPressed: () {},
                textColor: Colors.white,
                shape: StadiumBorder(),
                icon: Icon(
                  Icons.add_shopping_cart_outlined,
                ),
                label: Text('Add to cart'),
              ),
            ],
          )
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.end,
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     iconButtonWid(
          //         disable: false,
          //         color: Colors.black,
          //         icon: Icons.add,
          //         size: 30,
          //         onTap: () async {
          //         }),
          //     Padding(
          //       padding: const EdgeInsets.symmetric(horizontal:16.0),
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.end,
          //         children: [
          //           Container(
          //             height: 2,
          //             width: 20,
          //             color: Colors.grey,
          //           ),
          //         ],
          //       ),
          //     )
          //     ,
          //     iconButtonWid(
          //         icon: Icons.remove,
          //         disable:false,
          //         size: 30,
          //         color: Colors.black,
          //         onTap: () async {
          //
          //         }),
          //   ],
          // ),
        ],
      ),
    );
  }
}

class FavoriteHeart extends StatefulWidget {
  const FavoriteHeart({
    Key key,
  }) : super(key: key);

  @override
  _FavoriteHeartState createState() => _FavoriteHeartState();
}

class _FavoriteHeartState extends State<FavoriteHeart>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<Color> _colorAnimation;
  Animation<double> _sizeAnimation;

  bool isFavorite = false;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _colorAnimation = ColorTween(
      begin: Colors.orange[400],
      end: Colors.orange,
    ).animate(_animationController);
    _sizeAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween(begin: 30, end: 50),
        weight: 50,
      ),
      TweenSequenceItem<double>(
        tween: Tween(begin: 50, end: 30),
        weight: 50,
      )
    ]).animate(_animationController);

    _animationController.addStatusListener((status) {
      if (_animationController.isCompleted) {
        setState(() {
          isFavorite = true;
        });
      }
      if (_animationController.isDismissed) {
        setState(() {
          isFavorite = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        builder: (context, snapshot) {
          return Container(
            child: Center(
              child: IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: _colorAnimation.value,
                    size: _sizeAnimation.value,
                  ),
                  onPressed: () {
                    isFavorite
                        ? _animationController.reverse()
                        : _animationController.forward();
                  }),
            ),
          );
        });
  }
}
