import 'package:casanova/ui/views/product_view/product_details/widgets/product_actions.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key key,
    this.title,
    this.price,
    this.category,
    this.favoriteOnTap,
    this.onTap,
    this.imageUrl,
  }) : super(key: key);
  final String title;
  final String price;
  final String category;
  final Function favoriteOnTap;
  final Function onTap;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        // border: Border.all(color: Colors.grey[300]),
        boxShadow: [
          BoxShadow(
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(-1.5, 1.0),
            color: Colors.blue[100].withOpacity(.4),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Divider(),
          Container(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      '₦${price.toString()}',
                      style: TextStyle(
                          color: Colors.orange[700],
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    )),
                    FavoriteHeart()
                  ],
                ),
                Text(title),
                Text(
                  category,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
