import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';

import '../../../../ui/commons/sizes.dart';
import '../../../../ui/utils/number_to_currency_format.dart';
import '../../../../ui/views/widgets/button.dart';
import '../../../../services/checkout_api/checkout_api.dart';
import '../../../../model/cart/cart_detail.dart';
import '../../../../services/auth_api/auth_api.dart';

class CartDetailsValue extends StatelessWidget {
  final Function() ontap;
  final String buttonTitle;
  final bool addbutton;

  final authApi = GetIt.I.get<AuthApi>();

  CartDetailsValue({Key key, this.ontap, this.buttonTitle, this.addbutton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final cartApi = Provider.of<CheckoutApi>(context);
      return StreamBuilder<DocumentSnapshot>(
          stream: cartApi.getCartDetails(userID: authApi.users.userID),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            var cartDetail = CartDetails();
            cartDetail = CartDetails.fromDoc(snapshot.data);

            return Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: addbutton ? Colors.blue[100] : Colors.transparent,
                      spreadRadius: 3,
                      blurRadius: 5,
                    ),
                  ]),
              child: PaddingAll16(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      textNtrailingText(
                        context,
                        leadingText: 'Subtotal',
                        trailingText:
                            '₦${convertNumberToCurrency(cartDetail.totalAmount)}',
                        trailTextSetColor: false,
                      ),
                      textNtrailingText(
                        context,
                        leadingText: 'Delivery fee',
                        trailingText:
                            '₦${convertNumberToCurrency(cartDetail.deliveryFee)}',
                        trailTextSetColor: true,
                      ),
                      Divider(),
                      textNtrailingText(
                        context,
                        leadingText: 'Total',
                        trailingText:
                            '₦${convertNumberToCurrency(cartDetail.totalAmount + cartDetail.deliveryFee)}',
                        trailTextSetColor: true,
                      ),
                      addbutton ? Container() : sizedBoxHeight16,
                      addbutton
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GradiantButton(
                                  isOutline: false,
                                  title: buttonTitle.toUpperCase(),
                                  onPressed: ontap),
                            )
                          : Container(),
                    ]),
              ),
            );
          });
    });
  }
}

textNtrailingText(BuildContext context,
    {@required String leadingText,
    String trailingText,
    Widget isWidgetTrailin,
    @required bool trailTextSetColor}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(leadingText,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            )),
        isWidgetTrailin == null
            ? Text(
                trailingText,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: trailTextSetColor ? Colors.orange : Colors.grey[700],
                ),
              )
            : isWidgetTrailin,
      ],
    ),
  );
}
