import 'package:cloud_firestore/cloud_firestore.dart';

class ProductCategory {
  String category;
   String description;
  String imageUrl;
  List subCategory;
  String id;

  ProductCategory({
    this.id,
    this.subCategory,
    this.category,
    this.imageUrl,
    this.description,
  });

  factory ProductCategory.fromDoc(DocumentSnapshot doc) {
    final data = doc.data();
    return ProductCategory(
        id: doc.id,
        category: data['category'],
        subCategory: data['subCategory'],
        description: data['description'],
        imageUrl: data['imageUrl']);
  }
}
