import 'package:cloud_firestore/cloud_firestore.dart';

class RateReview {
  String orderID;
  String userID;
  double stars;
  String name;

  String reviewTitle;
  String rateStatus;
  String review;

  RateReview(
      {this.orderID,
      this.reviewTitle,
      this.userID,
      this.stars,
      this.rateStatus,
      this.name,
      this.review});

  factory RateReview.fromDoc(DocumentSnapshot doc) {
    final data = doc.data();
    return RateReview(
      orderID: doc.id,
      userID: data['userID'],
      stars: data['stars'],
      rateStatus: data['rateStatus'],
      reviewTitle: data['reviewTitle'],
      review: data['review'],
    );
  }

  Map<String, dynamic> toDoc() {
    var data = Map<String, dynamic>();
    data['id'] = this.orderID;
    data['userId'] = this.userID;
    data['stars'] = this.stars;
    data['rateStatus'] = this.rateStatus;
    data['review'] = this.review;
    data['name'] = this.name;

    return data;
  }
}
