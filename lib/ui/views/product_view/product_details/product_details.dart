import 'package:flutter/material.dart';
import '../../../../model/product/product.dart';
import '../../../../ui/views/product_view/product_details/widgets/product_actions.dart';
import '../../../../ui/views/product_view/product_details/widgets/product_image_display.dart';
import '../../../../ui/views/product_view/product_details/widgets/star_ratings.dart';
import '../../../../ui/views/product_view/product_details/widgets/text_expansion.dart';
import '../../../../ui/views/widgets/badge_with_value.dart';
import '../../../../view_models/theme_view_model/theme_model.dart';

class ProductDetails extends StatelessWidget {
  final Product product;

  final String hero;

  const ProductDetails({Key key, this.hero, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 8.0, top: 5),
                child: BadgeWithValue()),
          ],
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: Column(
                  children: [
                    _imageWithActions(),
                    SizedBox(height: 15),
                    FlatCardTitle(
                      title: 'Description',
                      widget: Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.white,
                        child: ExpandableText(product.description),
                      ),
                    ),
                    FlatCardTitle(
                        title: 'Ratings & Reviews',
                        widget: Container(
                          color: Colors.white,
                          child: Column(
                              children: List.generate(
                            5,
                            (index) => ListTile(
                              contentPadding: const EdgeInsets.all(8),
                              leading: CircleAvatar(radius: 15),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RatingStars(star: 3),
                                  Text('I love this product.'),
                                ],
                              ),
                              subtitle: Text('Paul Jeremiah'),
                              trailing: Text(
                                '12/02/2021',
                                style: TextStyle(color: grey400),
                              ),
                            ),
                          )),
                        ))
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                child: ProductReviewRatings(),
              ),
            ],
          ),
        ));
  }

  // ProductCard(
  // title: product.title,
  // price: product.price.toString(),
  // category: product.category,
  // favoriteOnTap: () {},
  // imageUrl: product.imageUrls[0],
  // onTap: () => Navigator.of(context).push(MaterialPageRoute(
  // builder: (_) => ProductDetails(
  // hero: product.imageUrls[0][i],
  // ))),
  // ),

  // Container(
  // child:
  // )

  Hero _imageWithActions() {
    return Hero(
      tag: hero,
      child: Container(
        height: 450,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15)),
        ),
        child: Column(
          children: [
            ImageDisplay(
              imageUrls: product.imageUrls,
            ),
            ProductActions(product: product),
          ],
        ),
      ),
    );
  }
}

class FlatCardTitle extends StatelessWidget {
  final Widget widget;
  final String title;

  const FlatCardTitle({
    Key key,
    this.widget,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Text(
          title,
          style: TextStyle(
              fontSize: 16, color: grey600, fontWeight: FontWeight.bold),
        ),
        widget ?? Container(),
      ],
    );
  }
}

class ProductReviewRatings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
//
// class RelatedProducts extends StatelessWidget {
//   const RelatedProducts({
//     Key key,
//     this.query,
//   }) : super(key: key);
//   final String query;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         TopText(
//           text: 'Customers Also Viewed',
//           color: Colors.grey[400],
//           fontWeight: FontWeight.w400,
//         ),
//         Container(
//           height: 200,
//           child: SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Consumer<ProductApi>(builder: (context, api, child) {
//               return StreamBuilder<QuerySnapshot>(
//                   stream: api.getProductBaseOnCategory(query),
//                   builder: (context, snapshot) {
//                     if (!snapshot.hasData) {
//                       return Center(child: CircularProgressIndicator());
//                     }
//                     final snap = snapshot.data;
//
//                     Product product = Product();
//                     List<Product> products = [];
//
//                     snap.docs.map((e) {
//                       product = Product.fromDoc(e);
//                       products.add(product);
//                     }).toList();
//                     return Row(
//                         children: List.generate(
//                       products.length,
//                       (index) {
//                         final kProducts = products[index];
//                         return Container(
//                           padding: const EdgeInsets.all(4),
//                           width: 150,
//                           child: ProductCard(
//                             title: kProducts.title,
//                             price: kProducts.price.toString(),
//                             category: '...',
//                             favoriteOnTap: () {},
//                             imageUrl: kProducts.imageUrls[0],
//                             onTap: () => Navigator.of(context).push(
//                                 MaterialPageRoute(
//                                     builder: (_) => ProductDetails(
//                                         product: kProducts,
//                                         hero: kProducts.imageUrls[0][index]))),
//                           ),
//                         );
//                       },
//                     ));
//                   });
//             }),
//           ),
//         ),
//       ],
//     );
//   }
// }
