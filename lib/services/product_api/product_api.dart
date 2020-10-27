import 'package:casanova/view_models/base_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductApi extends BaseViewModel {
  var productsRef = FirebaseFirestore.instance.collection('products');
  var productCatRef = FirebaseFirestore.instance.collection('productCategory');

  Stream<QuerySnapshot> getAllProducts() async* {
    try {
      yield* productsRef.snapshots();
    } catch (e) {
      print(e);
    }
  }

  ProductApi() {
    getCategories();
  }

  Stream<QuerySnapshot> getCategories() async* {
    try {
      yield* productCatRef.snapshots();
    } catch (e) {
      print(e);
    }
  }

  Stream<QuerySnapshot> getProductBaseOnCategory(query) async* {
    try {
      yield* productsRef.where('category', isEqualTo: query).snapshots();
    } catch (e) {
      print(e);
    }
  }
}
