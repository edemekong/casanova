import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../../model/product/product_category.dart';
import '../../../../../services/product_api/product_api.dart';
import '../../../../../ui/views/product_view/product_category/product_category.dart';
import '../../../../../ui/views/widgets/cart_card.dart';
import '../../../../../ui/views/widgets/top_text.dart';

class ProductCategories extends StatelessWidget {
  const ProductCategories({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductApi>(builder: (context, api, child) {
      return Column(
        children: [
          TopText(text: 'Categories'),
          Container(
            child: StreamBuilder<QuerySnapshot>(
                stream: api.getCategories(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  }

                  final snap = snapshot.data;

                  ProductCategory category = ProductCategory();
                  List<ProductCategory> categories = [];

                  snap.docs.map((e) {
                    category = ProductCategory.fromDoc(e);
                    categories.add(category);
                  }).toList();

                  return Wrap(
                    children: List.generate(
                      categories.length,
                      (i) {
                        var kCategories = categories[i];
                        return CatCards(
                            color: Colors.white,
                            title: kCategories.category,
                            imageUrl: kCategories.imageUrl,
                            onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => ProductCategoryItem(
                                          category: categories[i])),
                                ));
                      },
                    ),
                  );
                }),
          ),
        ],
      );
    });
  }
}
