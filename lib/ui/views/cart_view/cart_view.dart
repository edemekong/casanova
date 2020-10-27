import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../images_assets/images_assets.dart';
import '../../../model/cart/cart_items.dart';
import '../../../services/auth_api/auth_api.dart';
import '../../../services/cart_api/cart_api.dart';
import '../../../ui/commons/sizes.dart';
import '../../../ui/views/cart_view/widget/cart_item.dart';
import '../../../ui/views/cart_view/widget/cart_bottom_navigator.dart';
import '../../../ui/views/widgets/button.dart';
import '../../../view_models/home_view_model/home_view_model.dart';
import 'package:provider/provider.dart';

class CartView extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Cart'),
        centerTitle: true,
        backgroundColor: Colors.blue[100].withOpacity(.2),
      ),
      body: Container(
          decoration: BoxDecoration(
            color: Colors.blue[100].withOpacity(.2),
          ),
          child: OrderCart()),
    );
  }
}

class OrderCart extends StatelessWidget {
  OrderCart({
    Key key,
  }) : super(key: key);

  final authApi = GetIt.I.get<AuthApi>();

  @override
  Widget build(BuildContext context) {
    var user = authApi.users;
    return Consumer2<CartApi, HomeViewModel>(
        builder: (context, cartApi, homeModel, child) {
      return StreamBuilder<QuerySnapshot>(
          stream: cartApi.getAllServiceInCart(userID: user.userID),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            var cartItem = CartItem();
            List<CartItem> cartItems = [];

            var doc = snapshot.data.docs;
            doc.map((e) {
              cartItem = CartItem.fromDoc(e);
              cartItems.add(cartItem);
            }).toList();

            return Container(
                child: Column(
              children: [
                Expanded(
                  flex: 9,
                  child: cartItems.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.width / 2,
                              child: Image.asset(
                                ImageAssets.cartEmpty,
                                color: Colors.grey,
                              ),
                            ),
                            sizedBoxHeight24,
                            sizedBoxHeight24,
                            Text('Your laundry CART is currently \n emppty',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.grey[800])),
                            sizedBoxHeight24,
                            GradiantButton(
                              onPressed: () => homeModel.onTap(0),
                              width: 100,
                              title: 'Go Home',
                              isOutline: false,
                            ),
                          ],
                        )
                      : Container(
                          child: ListView.builder(
                              itemCount: cartItems.length,
                              itemBuilder: (ctx, i) {
                                var cart = cartItems[i];
                                return CartItems(
                                  cartItem: cart,
                                  user: user,
                                  cartApi: cartApi,
                                );
                              }),
                        ),
                ),
                Expanded(
                  flex: 1,
                  child: CartBottomNavigator(
                    cartItems: cartItems,
                    cartApi: cartApi,
                    user: user,
                  ),
                ),
              ],
            ));
          });
    });
  }
}
