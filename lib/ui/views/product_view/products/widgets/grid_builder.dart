// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:my_daily_wash/model/product/product_category.dart';
// import 'package:my_daily_wash/services/product_api/product_api.dart';
// import 'package:my_daily_wash/ui/commons/sizes.dart';
// import 'package:my_daily_wash/ui/views/widgets/cached_image.dart';
// import 'package:my_daily_wash/ui/views/widgets/cart_card.dart';
// import 'package:my_daily_wash/ui/views/widgets/custom_pageview.dart';
// import 'package:my_daily_wash/view_models/theme_view_model/theme_model.dart';
// import 'package:provider/provider.dart';
// import '../../product_category/product_category.dart';
//
// class GrideBuilder extends StatefulWidget {
//   const GrideBuilder({
//     Key key,
//     @required this.pageStorageKey,
//     this.gridDelegate,
//     this.delegate,
//   }) : super(key: key);
//
//   // final List<Widget> body;
//
//   final String pageStorageKey;
//
//   final SliverGridDelegate gridDelegate;
//   final SliverChildDelegate delegate;
//
//   @override
//   _GrideBuilderState createState() => _GrideBuilderState();
// }
//
// class _GrideBuilderState extends State<GrideBuilder> {
//   @override
//   Widget build(BuildContext context) {
//     return Builder(
//       builder: (BuildContext context) {
//         return CustomScrollView(
//           physics: BouncingScrollPhysics(),
//           key: PageStorageKey<String>(widget.pageStorageKey),
//           slivers: <Widget>[
//             SliverOverlapInjector(
//               handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
//             ),
//
//           ],
//         );
//       },
//     );
//   }
// }
//
// class TopText extends StatelessWidget {
//   const TopText({
//     Key key,
//     this.text, this.color, this.fontWeight,
//   }) : super(key: key);
//
//   final String text;
//   final Color color;
//   final FontWeight fontWeight;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       margin: const EdgeInsets.symmetric(vertical: 10),
//       width: MediaQuery.of(context).size.width,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
//         child: Text(
//           text,
//           style: TextStyle(
//               fontSize: 18, fontWeight:fontWeight ?? FontWeight.w600, color:color?? grey800),
//         ),
//       ),
//     );
//   }
// }
//
// class ProductCategories extends StatelessWidget {
//   const ProductCategories({
//     Key key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ProductApi>(builder: (context, api, child) {
//       return Container(
//         child: StreamBuilder<QuerySnapshot>(
//             stream: api.getCategories(),
//             builder: (context, snapshot) {
//               if (!snapshot.hasData) {
//                 return Container();
//               }
//
//               final snap = snapshot.data;
//
//               ProductCategory category = ProductCategory();
//               List<ProductCategory> categories = [];
//
//               snap.docs.map((e) {
//                 category = ProductCategory.fromDoc(e);
//                 categories.add(category);
//               }).toList();
//
//               return Wrap(
//                 children: List.generate(
//                   categories.length,
//                   (i) {
//                     var kCategories = categories[i];
//                     return CatCards(
//                         title: kCategories.category,
//                         imageUrl: kCategories.imageUrl,
//                         onTap: () => Navigator.of(context).push(
//                               MaterialPageRoute(
//                                   builder: (_) => ProductCategoryItem(
//                                       category: categories[i])),
//                             ));
//                   },
//                 ),
//               );
//             }),
//       );
//     });
//   }
// }
