import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String title;
  String description;
  List imageUrls;
  int price;
  int previousPrice;
  bool inStock;
  String category;

  Product(
      {this.title,
      this.description,
      this.imageUrls,
      this.price,
      this.previousPrice,
      this.inStock,
      this.category});

  factory Product.fromDoc(DocumentSnapshot doc) {
    final data = doc.data()
;    return Product(
      title: data['title'],
      description: data['description'],
      imageUrls: data['imageUrls'],
      price: data['price'],
      previousPrice:data['previousPrice'] ,
      inStock:data['inStock'] ,
      category: data['category'],
    );
  }



}
