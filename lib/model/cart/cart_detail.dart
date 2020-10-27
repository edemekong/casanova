import 'package:cloud_firestore/cloud_firestore.dart';

class CartDetails {
  String userID;
  int totalAmount;
  int deliveryFee;
  double totalValue;
  int totalItemCount;
  String deliveryTime;
  String pickUpTime;

  CartDetails(
      {this.userID,
      this.totalAmount,
      this.deliveryFee,
      this.totalValue,
      this.deliveryTime,
      this.pickUpTime,
      this.totalItemCount});

  factory CartDetails.fromDoc(DocumentSnapshot doc) {
    var data = doc.data();
    return CartDetails(
      userID: doc.id,
      totalItemCount: data['totalItemCount'],
      deliveryFee: data['deliveryFee'],
      totalAmount: data['totalAmount'],
      totalValue: data['totalValue'],
      deliveryTime: data['deliveryTime'],
      pickUpTime: data['pickUpTime'],
    );
  }

  toDoc(String orderID) {
    var data = Map<String, dynamic>();
    data['userID'] = this.userID;
    data['orderID'] = orderID;
    data['totalAmount'] = this.totalAmount;
    data['totalItemCount'] = this.totalItemCount;
    data['totalValue'] = this.totalValue;
    data['deliveryFee '] = this.deliveryFee;
    data['deliveryTime'] = this.deliveryTime;
    data['pickUpTime'] = this.pickUpTime;

    data['status'] = 'Received';
    return data;
  }
}
