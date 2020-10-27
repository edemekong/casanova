import 'package:casanova/model/product/product.dart';
import 'package:casanova/model/product/product_category.dart';
import 'package:casanova/services/product_api/product_api.dart';
import 'package:casanova/ui/views/product_view/product_details/product_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductCategoryItem extends StatelessWidget {
  final ProductCategory category;

  const ProductCategoryItem({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(category.category),
      ),
      body: Consumer<ProductApi>(builder: (context, api, child) {
        return StreamBuilder<QuerySnapshot>(
            stream: api.getProductBaseOnCategory(category.category),
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

              return GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    crossAxisCount: 2,
                    childAspectRatio: 2 / 2.8),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => ProductDetails(
                              hero: products[index].imageUrls[0][index],
                              product: products[index],
                            ))),
                    child: Container(
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
                            child: Container(
                              child: Image.network(
                                products[index].imageUrls[0],
                                fit: BoxFit.cover,
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
                                      '₦${products[index].price}',
                                      style: TextStyle(
                                          color: Colors.orange[700],
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )),
                                    Icon(
                                      Icons.favorite_border,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                                Text(products[index].title),
                                Text(
                                  products[index].category,
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          )),
                        ],
                      ),
                    ),
                  );
                },
              );
            });
      }),
    );
  }
}
