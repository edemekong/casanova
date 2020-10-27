import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../model/product/product.dart';
import '../../../../services/product_api/product_api.dart';
import '../../../../ui/views/home_view/home/widget/custom_scroll.dart';
import '../../../../ui/views/product_view/product_details/product_details.dart';
import '../../../../ui/views/product_view/products/product_category/product_category.dart';
import '../../../../ui/views/product_view/widget/product_card.dart';
import '../../../../ui/views/widgets/top_text.dart';

class AllProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductApi>(builder: (context, api, child) {
      return StreamBuilder<QuerySnapshot>(
          stream: api.getAllProducts(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            final snap = snapshot.data;

            Product product = Product();
            List<Product> products = [];

            snap.docs.map((e) {
              product = Product.fromDoc(e);
              products.add(product);
            }).toList();

            return CustomScroll(
                pageStorageKey: '124',
                body: [ProductCategories(), TopText(text: 'All Products')],
                widget: SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        crossAxisCount: 2,
                        childAspectRatio: 2 / 2.8),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final kProduct = products[index];
                        return ProductCard(
                          title: kProduct.title,
                          price: kProduct.price.toString(),
                          category: kProduct.category,
                          favoriteOnTap: () {},
                          imageUrl: kProduct.imageUrls[0],
                          onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => ProductDetails(
                                        hero: products[index].imageUrls[0]
                                            [index],
                                        product: products[index],
                                      ))),
                        );
                      },
                      childCount: products.length,
                    ),
                  ),
                ));
          });
    });
  }
}
