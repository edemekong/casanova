import 'package:cloud_firestore/cloud_firestore.dart';

class CartItem {
  String id;
  String title;
  String subCategory;
  String category;
  int quantity;
  int newServicePrice;
  int servicePrice;
  double serviceValue;

  CartItem(
      {this.id,
      this.category,
      this.servicePrice,
      this.title,
      this.quantity,
      this.newServicePrice,
      this.subCategory,
      this.serviceValue});

  factory CartItem.fromDoc(DocumentSnapshot doc) {
    var data = doc.data();
    return CartItem(
        id: doc.id,
        title: data['title'],
        category: data['category'],
        subCategory: data['subCategory'],
        quantity: data['quantity'],
        newServicePrice: data['newServicePrice'],
        servicePrice: data['servicePrice'],
        serviceValue: data['serviceValue']);
  }

  Map<String, dynamic> toDoc() {
    var data = Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['category'] = category;
    data['subCategory'] = subCategory;
    data['quantity'] = 1;
    data['servicePrice'] = servicePrice;
    data['newServicePrice'] = newServicePrice;
    data['serviceValue'] = serviceValue;
    return data;
  }

  Map<String, dynamic> toDocWithValue({
    String id,
    String title,
    String category,
    String subCategory,
    double serviceValue,
    int quantity,
    int servicePrice,
    int newServicePrice,
  }) {
    var data = Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['category'] = category;
    data['subCategory'] = subCategory;
    data['quantity'] = quantity;
    data['servicePrice'] = servicePrice;
    data['newServicePrice'] = newServicePrice;
    data['serviceValue'] = serviceValue;
    return data;
  }
}
