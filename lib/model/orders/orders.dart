import 'package:cloud_firestore/cloud_firestore.dart';

class Orders {
  String orderID;
  String userID;
  String status;
  String howOften;
  String deliveryTime;
  String pickUpTime;
  int deliveryFee;
  int totalAmount;
  int totalItemCount;
  double totalValue;

  Orders({
    this.status,
    this.deliveryFee,
    this.deliveryTime,
    this.orderID,
    this.pickUpTime,
    this.totalAmount,
    this.howOften,
    this.totalItemCount,
    this.totalValue,
    this.userID,
  });

  factory Orders.fromDoc(DocumentSnapshot doc) {
    var data = doc.data();
    return Orders(
      orderID: doc.id,
      userID: data['userID'],
      totalItemCount: data['totalItemCount'],
      deliveryFee: data['deliveryFee'],
      totalAmount: data['totalAmount'],
      totalValue: data['totalValue'],
      deliveryTime: data['deliveryTime'],
      pickUpTime: data['pickUpTime'],
      status: data['status'],
      howOften: data['howOften'],
    );
  }

  toDoc(
      {String userID,
      int deliveryFee,
      String pickUpTime,
      String howOften,
      int totalAmount,
      int totalItemCount,
      double totalValue,
      String deliveryTime}) {
    var data = Map<String, dynamic>();
    data['userID'] = userID ?? '';
    data['deliveryFee'] = deliveryFee ?? 300;
    data['pickUpTime'] = pickUpTime ?? '';
    data['howOften'] = howOften ?? '';
    data['totalAmount'] = totalAmount ?? 0;
    data['totalItemCount'] = totalItemCount ?? 0;
    data['totalValue'] = totalValue ?? 0.0;
    data['deliveryTime'] = deliveryTime ?? '';
    return data;
  }
}

class OrderItems {
  String serviceID;
  String serviceName;
  String servicesName;
  String serviceCategory;
  int servicePrice;
  double serviceValue;
  int serviceCount;
  int quantity;

  OrderItems(
      {this.serviceID,
      this.quantity,
      this.serviceCount,
      this.serviceName,
      this.servicesName,
      this.serviceCategory,
      this.servicePrice,
      this.serviceValue});

  factory OrderItems.fromDoc(DocumentSnapshot doc) {
    var data = doc.data();
    return OrderItems(
      serviceID: doc.id,
      servicesName: data['servicesName'],
      serviceName: data['serviceName'],
      serviceCategory: data['serviceCategory'],
      servicePrice: data['servicePrice'],
      serviceValue: data['serviceValue'],
      serviceCount: data['serviceCount'],
      quantity: data['quantity'],
    );
  }

  Map<String, dynamic> toDoc() {
    var data = Map<String, dynamic>();
    data['serviceID'] = this.serviceID;
    data['serviceName'] = this.serviceName;
    data['servicesName'] = this.servicesName;
    data['serviceCategory'] = this.serviceCategory;
    data['servicePrice'] = this.servicePrice;
    data['serviceValue'] = this.serviceValue;
    data['serviceCount'] = this.serviceCount;
    return data;
  }
}
