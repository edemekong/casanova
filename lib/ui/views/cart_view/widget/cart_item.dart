import 'package:casanova/model/cart/cart_items.dart';
import 'package:casanova/services/cart_api/cart_api.dart';
import 'package:casanova/ui/commons/sizes.dart';
import 'package:casanova/ui/utils/number_to_currency_format.dart';
import 'package:casanova/ui/views/widgets/button.dart';
import 'package:casanova/view_models/theme_view_model/theme_model.dart';
import 'package:flutter/material.dart';
import '../../../../model/user/user.dart';
import '../../../../ui/views/widgets/alert_dialog.dart';

class CartItems extends StatelessWidget {
  final CartApi cartApi;
  final CartItem cartItem;
  final Users user;

  const CartItems({
    Key key,
    this.cartApi,
    this.cartItem,
    this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            spreadRadius: 2,
            blurRadius: 10,
            color: Colors.blue[600].withOpacity(.2),
          ),
        ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Expanded(
                child: PaddingVertical8Horizontal16(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                        style: TextStyle(color: Colors.grey),
                        children: [
                          TextSpan(
                            text: '${cartItem.title}\n',
                            style: TextStyle(
                                color: black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          TextSpan(
                            text: '${cartItem.category}\n',
                            style: TextStyle(color: grey800, fontSize: 14),
                          ),
                          TextSpan(
                            text: '${cartItem.subCategory}, ',
                            style: TextStyle(color: grey500, fontSize: 12),
                          ),
                          TextSpan(
                            text:
                                '₦${convertNumberToCurrency(cartItem.newServicePrice)}',
                            style: TextStyle(
                                color: Colors.blue[400],
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ]),
                  ),
                  PaddingAll8(
                    child: Row(
                      children: [
                        Chip(
                          backgroundColor: Colors.blue[100],
                          label: Text(
                            'Qty: ${cartItem.quantity}',
                            style: TextStyle(
                                color: grey800,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      iconButtonWid(
                          disable: false,
                          color: Colors.black,
                          icon: Icons.add,
                          onTap: () async {
                            await cartApi.addServiceToCart(
                              context,
                              userID: user.userID,
                              id: cartItem.id,
                              title: cartItem.title,
                              serviceValue: cartItem.serviceValue,
                              servicePrice: cartItem.servicePrice,
                              subCategory: cartItem.subCategory,
                              category: cartItem.category,
                            );
                          }),
                      sizedBoxWidth16,
                      iconButtonWid(
                          icon: Icons.remove,
                          disable: cartItem.quantity <= 1 ? true : false,
                          color: Colors.black,
                          onTap: () async {
                            await cartApi.removeSingleServiceFromCart(
                              context,
                              userID: user.userID,
                              id: cartItem.id,
                              title: cartItem.title,
                              serviceValue: cartItem.serviceValue,
                              category: cartItem.category,
                              subCategory: cartItem.subCategory,
                              servicePrice: cartItem.servicePrice,
                            );
                          }),
                    ],
                  ),
                ],
              ),
            )),
            Divider(color: grey300, height: 4),
            Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    flatButtonWithIconWid(
                      title: 'Save for later',
                      icon: Icons.bookmark,
                      textColors: Colors.orange,
                      color: Colors.orange,
                      onTap: () {
                        // print(id);
                      },
                    ),
                    flatButtonWithIconWid(
                      title: 'Remove',
                      textColors: Colors.red,
                      icon: Icons.delete,
                      color: Colors.red,
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (ctx) => CustomAlertDialog(
                                title: 'Romove from cart?',
                                content:
                                    'Do you want to remove this service from cart?',
                                onTapYes: () => cartApi.removeServiceFromCart(
                                      context,
                                      userID: user.userID,
                                      id: cartItem.id,
                                    )));
                      },
                    ),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
