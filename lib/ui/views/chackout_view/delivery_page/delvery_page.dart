import 'package:flutter/material.dart';
import '../../../../ui/commons/sizes.dart';
import '../../../../ui/commons/styles.dart';
import '../../../../ui/views/chackout_view/widgets/checkout_nav.dart';
import '../../../../ui/views/chackout_view/widgets/detail_card.dart';
import '../../../../ui/views/chackout_view/widgets/name_address.dart';
import '../../../../ui/views/profile_view/edit_profile.dart';
import '../../../../ui/views/widgets/button.dart';
import '../../../../ui/views/widgets/card_wid.dart';
import '../../../../view_models/checkout_view_model/delivery_view_model.dart';
import '../../../../view_models/theme_view_model/theme_model.dart';
import '../../../../model/cart/cart_items.dart';

import 'package:provider/provider.dart';
import '../../../../model/user/user.dart';

class DeliveryPage extends StatelessWidget {
  final Users user;
  final List<CartItem> cartItems;
  final Function onTap;

  const DeliveryPage({Key key, this.onTap, this.cartItems, this.user})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final deliveryViewModel = Provider.of<DeliveryViewModel>(context);

    return Column(
      children: [
        Expanded(
            child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                DetailCard(
                    detialType: 'Address details',
                    onTapChange: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => EditProfile())),
                    body: AddressName()),
                sizedBoxHeight8,
                PaddingVertical8Horizontal16(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SELECT A DELIVERY METHOD',
                        style: TextStyle(
                          fontSize: 12,
                          color: grey500,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      _deliveryMethodCard(context, deliveryViewModel),
                      DetailCard(
                        detialType: 'Items details',
                        onTapChange: () => Navigator.of(context).pop(),
                        body: Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Column(
                              children:
                                  List.generate(cartItems.length, (index) {
                            var cart = cartItems[index];
                            return ListTile(
                              title: Text(cart.title),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(cart.category),
                                  Text(cart.subCategory),
                                ],
                              ),
                              leading: Chip(
                                label: Text("Qty: ${cart.quantity}"),
                                backgroundColor: Colors.blue[100],
                              ),
                              trailing: Text("N${cart.servicePrice}"),
                            );
                          })),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        )),
        CartDetailsValue(
          addbutton: true,
          buttonTitle: 'PROCEED TO PAYMENT',
          ontap: deliveryViewModel.dateTime == null ? null : () => onTap(1),
        ),
      ],
    );
  }

  _deliveryMethodCard(
      BuildContext context, DeliveryViewModel deliveryViewModel) {
    var textStyle = ({double fontSize, Color fontColor}) =>
        TextStyle(fontSize: fontSize ?? 15, color: fontColor ?? grey600);
    return CardWid(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headerTextForContent('Schedule Pick-up Time/Day'),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: 'Day\n', style: textStyle()),
                    TextSpan(
                      text: deliveryViewModel.dateTime == null
                          ? 'set date'
                          : '${deliveryViewModel.dateTime}'.substring(0, 11),
                      style: textStyle(
                        fontSize: 12,
                        fontColor: deliveryViewModel.dateTime == null
                            ? Colors.red
                            : grey600,
                      ),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Time\n',
                      style: TextStyle(
                          fontSize: 14,
                          color: grey600,
                          fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                      text: deliveryViewModel.timeOfDay == null
                          ? 'set time'
                          : deliveryViewModel.timeOfDay == null
                              ? 'set time'
                              : deliveryViewModel.timeOfDay,
                      style: TextStyle(
                          fontSize: 12,
                          color: deliveryViewModel.timeOfDay == null
                              ? Colors.red
                              : grey600,
                          fontWeight: FontWeight.w500),
                    ),
                    TextSpan(
                      text:
                          deliveryViewModel.timeOfDay == null ? '' : '  x2 hrs',
                      style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              flatButtonWithIcon(
                context,
                title: 'Set time',
                textColor: Colors.white,
                icon: Icons.alarm_add,
                onPressed: () => deliveryViewModel.setDateTime(context, user),
              ),
            ]),
            Divider(height: 50),
            headerTextForContent('Schedule Drop-off day/Time'),
            Row(
              children: [
                Expanded(
                  child: CheckboxListTile(
                    contentPadding: const EdgeInsets.all(0),
                    value: deliveryViewModel.timeCheck['2 to 3 days'],
                    onChanged: (val) => deliveryViewModel.setDeliveryTimeDays(
                        context,
                        userID: user.userID,
                        value: val),
                    title: Text(
                      '2 to 4 days',
                      style: TextStyle(color: grey600),
                    ),
                  ),
                ),
                sizedBoxWidth8,
                Expanded(
                  child: CheckboxListTile(
                    contentPadding: const EdgeInsets.all(0),
                    value: deliveryViewModel.timeCheck['Tomorrow'],
                    onChanged: (val) {
                      return deliveryViewModel.setDeliveryTimeTomorrow(context,
                          userID: user.userID, value: val);
                    },
                    title: Text(
                      'Tomorrow',
                      style: TextStyle(color: grey600),
                    ),
                    subtitle: Text('[12%]'),
                  ),
                ),
              ],
            ),
            Divider(height: 50),
            headerTextForContent('How often?(Optional)'),
            DropdownButton(
              isExpanded: true,
              value: deliveryViewModel.initialHowOftenValue,
              items: deliveryViewModel.howOftenItems
                  .map(
                    (e) => DropdownMenuItem(
                      value: e.value,
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        title: Text(e.value,
                            style: TextStyle(fontSize: 16, color: grey600)),
                        trailing: e.value.contains('Bi-Weekly')
                            ? Icon(Icons.check_circle, color: Colors.green)
                            : null,
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (v) => deliveryViewModel.setHowOften(context, v, user),
            ),
          ],
        ),
      ),
    );
  }

  headerTextForContent(String text) {
    return Text(text, style: titleOnCard);
  }

  subTextForContent(String text) {
    return Text(
      text,
      style:
          TextStyle(fontSize: 13, color: grey600, fontWeight: FontWeight.w600),
    );
  }
}
