import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderApi extends ChangeNotifier {
  var orderRef = FirebaseFirestore.instance.collection('orders');

  Future<DocumentSnapshot> getOrder(String orderID) async {
    return await orderRef.doc(orderID).get();
  }

  Stream<QuerySnapshot> getUserOrder(userID) async* {
    yield* orderRef.where('userID', isEqualTo: userID).snapshots();
  }

  Stream<QuerySnapshot> getOrderItems(String orderID) async* {
    yield* orderRef.doc(orderID).collection('orderItems').snapshots();
  }
}
