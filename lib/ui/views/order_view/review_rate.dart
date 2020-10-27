import 'package:flutter/material.dart';
import '../../../model/user/user.dart';
import '../../../ui/commons/sizes.dart';
import '../../../ui/views/widgets/button.dart';
import '../../../ui/views/widgets/text_field_wid.dart';
import '../../../view_models/rate_review_model/rate_review_model.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ReviewRateService extends StatefulWidget {
  final String orderID;
  final Users users;

  const ReviewRateService({Key key, this.orderID, this.users})
      : super(key: key);
  @override
  _ReviewRateServiceState createState() => _ReviewRateServiceState();
}

class _ReviewRateServiceState extends State<ReviewRateService> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Consumer<RateReviewModel>(builder: (context, rateModel, child) {
      rateModel.nameController.text = widget.users.fullName ?? '';
      return Column(
        children: [
          Container(
            color: Colors.yellow,
            height: 50,
            width: screenSize.width,
            child: PaddingAll16(
              child: Center(
                child: Text('RATE THESE SERVICE',
                    style: TextStyle(fontWeight: FontWeight.w700)),
              ),
            ),
          ),
          Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SmoothStarRating(
                      allowHalfRating: false,
                      onRated: rateModel.changeStatus,
                      starCount: 5,
                      rating: rateModel.rating,
                      size: 40.0,
                      isReadOnly: rateModel.isRate ? true : false,
                      color: Colors.orange,
                      borderColor: Colors.orangeAccent,
                      spacing: 0.0),
                ),
                Text(
                  rateModel.rateStatus,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Divider(),
                flatButtonWithIcon(context,
                    onPressed: rateModel.rating == 0.0
                        ? null
                        : () {
                            setState(() {
                              rateModel.isRate = true;
                            });
                          },
                    textColor: Colors.white,
                    title: 'Rate here',
                    icon: Icons.rate_review),
                rateModel.isRate
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            TextFieldWidRounded(
                              title: 'Review Title',
                              obscureText: false,
                              maxLine: 1,
                              controller: rateModel.reviewTitleController,
                            ),
                            TextFieldWidRounded(
                              title: 'Write Review here',
                              obscureText: false,
                              maxLine: 6,
                              controller: rateModel.reviewController,
                            ),
                            TextFieldWidRounded(
                              title: 'Your Name',
                              obscureText: false,
                              maxLine: 1,
                              controller: rateModel.nameController,
                            ),
                            sizedBoxHeight16,
                            GradiantButton(
                                isOutline: false,
                                onPressed: () => rateModel.postRateReview(
                                    context,
                                    widget.orderID,
                                    widget.users.userID),
                                title: 'Send Review'),
                            sizedBoxHeight16,
                          ],
                        ),
                      )
                    : sizedBoxHeight16,
              ],
            ),
          ),
        ],
      );
    });
  }
}
