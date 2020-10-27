import 'package:casanova/model/rate_review/rate_review.dart';
import 'package:casanova/services/rate_review_api/rate_review_api.dart';
import 'package:casanova/ui/views/widgets/snacks.dart';
import 'package:casanova/view_models/base_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

class RateReviewModel extends BaseViewModel {
  var rateReviewApi = GetIt.I.get<RateReviewApi>();
  var rating = 0.0;

  String rateStatus = '';

  bool isRate = false;

  TextEditingController reviewTitleController = TextEditingController();
  TextEditingController reviewController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  changeStatus(value) {
    rating = value;
    if (value == 1) {
      rateStatus = 'Poor';
    } else if (value == 0) {
      rateStatus = '';
    } else if (value == 2) {
      rateStatus = 'Okay';
    } else if (value == 3) {
      rateStatus = 'Good';
    } else if (value == 4) {
      rateStatus = 'Very Good';
    } else if (value == 5) {
      rateStatus = 'Exellent';
    }
    notifyListeners();
  }

  postRateReview(context, String orderID, String userID) async {
    var reviewRate = RateReview();
    reviewRate.name = nameController.text;
    reviewRate.reviewTitle = reviewTitleController.text;
    reviewRate.review = reviewController.text;
    reviewRate.orderID = orderID;
    reviewRate.userID = userID;
    reviewRate.stars = rating;
    reviewRate.rateStatus = rateStatus;
    notifyListeners();

    try {
      await rateReviewApi.postRateReview(orderID, reviewRate.toDoc());
      isRate = false;
      showSnackbar(context,
          msg:
              'Thank you for rating these service with ${rating.toInt()} stars!!');
      rating = 0.0;
      rateStatus = '';
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
