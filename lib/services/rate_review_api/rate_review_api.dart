import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class RateReviewApi extends ChangeNotifier {
  var rateReviewRef = FirebaseFirestore.instance.collection('rate_review');

  postRateReview(String orderID, Map<String, dynamic> map) async {
    await rateReviewRef.doc(orderID).set(map);
  }
}
