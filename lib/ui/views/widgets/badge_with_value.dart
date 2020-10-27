import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../services/auth_api/auth_api.dart';
import '../../../services/cart_api/cart_api.dart';
import '../../../ui/views/cart_view/cart_view.dart';

import 'badge.dart';

class BadgeWithValue extends StatelessWidget {
  final double fontSize;

  final IconData iconData;

  BadgeWithValue({Key key, this.fontSize, this.iconData}) : super(key: key);

  final authApi = GetIt.I.get<AuthApi>();

  @override
  Widget build(BuildContext context) {
    var user = authApi.users;
    return Consumer<CartApi>(builder: (context, cartApi, child) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: StreamBuilder<QuerySnapshot>(
            stream: cartApi.getAllServiceInCart(userID: user.userID),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return IconButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: () {},
                    icon: Icon(
                      Icons.shopping_cart_outlined,
                      size: 25,
                      color: Colors.grey[800],
                    ));
              }
              var doc = snapshot.data.docs;

              return Badge(
                  child: IconButton(
                      padding: const EdgeInsets.all(0),
                      icon: Icon(
                        iconData ?? Icons.shopping_cart_outlined,
                        size: fontSize ?? 25,
                        color: Colors.grey[600],
                      ),
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx) => CartView()))),
                  value: doc.length.toString());
            }),
      );
    });
  }
}

class BottomBadge extends StatelessWidget {
  final double fontSize;

  final IconData iconData;

  final Color color;

  BottomBadge({Key key, this.fontSize, this.iconData, this.color})
      : super(key: key);

  final authApi = GetIt.I.get<AuthApi>();

  @override
  Widget build(BuildContext context) {
    var user = authApi.users;
    return Consumer<CartApi>(builder: (context, cartApi, child) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: StreamBuilder<QuerySnapshot>(
            stream: cartApi.getAllServiceInCart(userID: user.userID),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: color,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Badge(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          iconData ?? Icons.shopping_cart_outlined,
                          size: fontSize ?? 25,
                          color: color,
                        ),
                      ),
                      value: '',
                    ));
              }
              var doc = snapshot.data.docs;
              // print('running${doc.length}');

              return Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: color,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Badge(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        iconData ?? Icons.shopping_cart_outlined,
                        size: fontSize ?? 25,
                        color: color,
                      ),
                    ),
                    value: doc.length.toString()),
              );
            }),
      );
    });
  }
}
