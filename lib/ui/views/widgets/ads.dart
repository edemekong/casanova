import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../model/ads/ads.dart';
import '../../../model/user/user.dart';
import '../../../services/ads_api/ads_api.dart';
import '../../../ui/commons/sizes.dart';
import '../../../ui/views/widgets/slide_dots.dart';
import '../../../view_models/ads_view_model.dart/ads_view_model.dart';
import 'package:provider/provider.dart';

import 'animated_icon.dart';
import 'custom_pageview.dart';

class AdsView extends StatelessWidget {
  final Users users;

  const AdsView({Key key, this.users}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer2<AdsApi, AdsViewModel>(
      builder: (BuildContext context, adsApi, adsModel, Widget child) {
        return StreamBuilder<QuerySnapshot>(
            stream: adsApi.getAds(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              var doc = snapshot.data.docs;
              Ads ad = Ads();
              List<Ads> ads = [];
              doc.map((e) {
                ad = Ads.fromDoc(e);
                ads.add(ad);
              }).toList();
              return Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.20,
                    child: CustomPageView(
                      viewportDirection: false,
                      controller: adsModel.pageController,
                      onPageChanged: adsModel.onPageChanged,
                      children: [
                        Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(4),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Center(
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(height: 1.3),
                                    children: [
                                      TextSpan(
                                        text: 'Welcome, ${users.fullName}',
                                        style: TextStyle(
                                          color: Colors.orange[700],
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      WidgetSpan(child: Divider()),
                                      TextSpan(
                                        text:
                                            """\nChoose the laundry service, which you are 
interested in today...""",
                                        style: TextStyle(
                                          color: Colors.grey[800],
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            AnimatedIconButton(adsModel: adsModel),
                          ],
                        ),
                        for (int i = 0; i < ads.length; i++)
                          Container(
                            margin: const EdgeInsets.all(4),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: CachedNetworkImageProvider(
                                      ads[i].imageUrl)),
                            ),
                          ),
                      ],
                    ),
                  ),
                  sizedBoxHeight8,
                  Container(
                    height: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < ads.length; i++)
                          if (i == adsModel.pageIndex)
                            SlideDotsAds(true)
                          else
                            SlideDotsAds(false)
                      ],
                    ),
                  ),
                ],
              );
            });
      },
    );
  }
}
