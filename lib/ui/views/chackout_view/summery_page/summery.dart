import 'package:casanova/ui/commons/sizes.dart';
import 'package:casanova/ui/views/cart_view/cart_view.dart';
import 'package:casanova/ui/views/chackout_view/widgets/checkout_nav.dart';
import 'package:casanova/ui/views/chackout_view/widgets/detail_card.dart';
import 'package:casanova/ui/views/chackout_view/widgets/name_address.dart';
import 'package:casanova/ui/views/profile_view/edit_profile.dart';
import 'package:casanova/ui/views/widgets/button.dart';
import 'package:casanova/ui/views/widgets/card_wid.dart';
import 'package:casanova/view_models/theme_view_model/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:casanova/view_models/checkout_view_model/delivery_view_model.dart';
import 'package:casanova/view_models/checkout_view_model/summery_view_model.dart';
import '../../../../model/user/user.dart';

class SummeryPage extends StatefulWidget {
  final Users user;

  const SummeryPage({Key key, this.user}) : super(key: key);

  @override
  _SummeryPageState createState() => _SummeryPageState();
}

class _SummeryPageState extends State<SummeryPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<DeliveryViewModel, SummeryViewModel>(
        builder: (context, deliveryModel, summeryModel, child) {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                flex: 5,
                child: Container(
                  child: ListView(
                    children: [
                      DetailCard(
                        detialType: 'YOUR ORDER',
                        onTapChange: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (ctx) => CartView())),
                        body: Container(
                            // padding: paddingAll16,
                            child: CartDetailsValue(
                          addbutton: false,
                        )),
                      ),
                      sizedBoxHeight8,
                      DetailCard(
                        detialType: 'ADDRESS DETAILS',
                        onTapChange: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (ctx) => EditProfile())),
                        body: AddressName(),
                      ),
                      PaddingVertical8Horizontal16(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'DELIVERY METHOD & DELIVERY TIME',
                              style: TextStyle(
                                fontSize: 12,
                                color: grey500,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            CardWid(
                              child: PaddingAll8(
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text('Delivery Location:'),
                                      Chip(
                                          backgroundColor: primaryColor,
                                          label: Text(
                                              'My Address || ${deliveryModel.deliveryTime}')),
                                      Text('Pick up Time & Day'),
                                      Chip(
                                          backgroundColor: primaryColor,
                                          label: Text(
                                              '${deliveryModel.dateTime}|| ${deliveryModel.timeOfDay} x2 Hrs')),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      PaddingVertical8Horizontal16(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'PAYMENT METHOD',
                              style: TextStyle(
                                fontSize: 12,
                                color: grey500,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            CardWid(
                              child: PaddingAll8(
                                child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: textNtrailingText(context,
                                        trailTextSetColor: true,
                                        leadingText: 'Payment',
                                        isWidgetTrailin: Chip(
                                            backgroundColor: primaryColor,
                                            label: Text('Not available')))),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
            PaddingAll16(
              child: raisedButtonAcrossApp(context, title: 'CONFIRM',
                  onTap: () async {
                await summeryModel.postOrder(context,
                    userID: widget.user.userID);
              }),
            ),
          ],
        ),
      );
    });
  }
}
