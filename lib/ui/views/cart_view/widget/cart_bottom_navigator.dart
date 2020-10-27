import 'package:casanova/model/cart/cart_items.dart';
import 'package:casanova/services/cart_api/cart_api.dart';
import 'package:casanova/ui/commons/sizes.dart';
import 'package:casanova/ui/utils/number_to_currency_format.dart';
import 'package:casanova/ui/views/chackout_view/checkout_view.dart';
import 'package:casanova/ui/views/widgets/button.dart';
import 'package:casanova/view_models/theme_view_model/theme_model.dart';
import 'package:flutter/material.dart';
import '../../../../model/user/user.dart';

class CartBottomNavigator extends StatelessWidget {
  final List<CartItem> cartItems;
  final CartApi cartApi;
  final Users user;
  CartBottomNavigator({Key key, this.cartItems, this.cartApi, this.user})
      : super(key: key);
  double totalValue = 0.1;

  @override
  Widget build(BuildContext context) {
    int totalAmount = 0;

    cartItems.forEach((element) {
      totalValue += element.serviceValue;
      totalAmount += element.newServicePrice.toInt();
    });

    return totalAmount == 0.0
        ? Container()
        : Container(
            margin: const EdgeInsets.symmetric(vertical: 0),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 2,
                    blurRadius: 10,
                    color: Colors.blue[600].withOpacity(.2),
                  ),
                ],
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
            child: PaddingVertical8Horizontal16(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                        text: TextSpan(
                            style: TextStyle(color: Colors.grey),
                            children: [
                          TextSpan(
                            text: 'Total\n',
                            style: TextStyle(
                                color: grey600,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                          TextSpan(
                            text: '₦${convertNumberToCurrency(totalAmount)}\n',
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                        ])),
                    raisedButtonAcrossApp(
                      context,
                      title: 'Place Order',
                      color: secondaryColor,
                      onTap: totalAmount == 0.0
                          ? null
                          : () async {
                              await cartApi.updateCartDetail(
                                totalValue: 10,
                                userID: user.userID,
                                totalAmount: totalAmount,
                                deliveryFee: 300,
                                deliveryTime: '',
                                pickUpTime: '',
                                totalItemCount: cartItems.length,
                              );
                              Navigator.of(context).push(MaterialPageRoute(
                                  fullscreenDialog: true,
                                  builder: (ctx) => CheckoutView(
                                        cartItems: cartItems,
                                      )));
                            },
                      textColor: white,
                    )
                  ]),
            ),
          );
  }
}
