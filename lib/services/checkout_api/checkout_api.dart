import 'package:casanova/model/cart/cart_detail.dart';
import 'package:casanova/model/cart/cart_items.dart';
import 'package:casanova/services/cart_api/cart_api.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';

class CheckoutApi extends ChangeNotifier {
  var orderRef = FirebaseFirestore.instance.collection('orders');

  var cartApi = GetIt.I.get<CartApi>();

  Stream<DocumentSnapshot> getCartDetails({@required String userID}) async* {
    yield* cartApi.cartRef.doc(userID).snapshots();
  }

  Future<void> clearCart({String userID}) async {
    var col = cartApi.cartRef.doc(userID).collection('cart_items');
    var cartSnap = col.snapshots();
    var cartItem = CartItem();
    var cartItems = <CartItem>[];
    try {
      cartSnap.forEach((event) async {
        event.docs.forEach((element) async {
          cartItem = CartItem.fromDoc(element);
          cartItems.add(cartItem);
          for (int i = 0; i < cartItems.length; i++) {
            debugPrint(i.toString());
            await col.doc(cartItems[i].id).delete();
            break;
          }
        });
      });
    } on Exception catch (e) {
      print(e);
    }
  }

  sendAllCartItemsToOrder(
      {@required String userID, @required String orderID}) async {
    var cartSnap =
        cartApi.cartRef.doc(userID).collection('cart_items').snapshots();
    var orderSnap = orderRef.doc(orderID).collection('orderItems');
    var order = orderRef.doc(orderID);
    var cartItem = CartItem();
    var cartItems = <CartItem>[];
    try {
      cartSnap.map((event) async {
        event.docs.forEach((element) async {
          cartItem = CartItem.fromDoc(element);
          cartItems.add(cartItem);
          for (int i = 0; i < cartItems.length; i++) {
            await orderSnap.doc(cartItems[i].id).set(
                  cartItem.toDocWithValue(
                    id: cartItems[i].id,
                    title: cartItems[i].title,
                    category: cartItems[i].category,
                    subCategory: cartItems[i].subCategory,
                    servicePrice: cartItems[i].servicePrice,
                    serviceValue: cartItems[i].serviceValue,
                    quantity: cartItems[i].quantity,
                  ),
                );
          }

          print(cartItems);
        });
      }).toList();

      cartApi.cartRef.doc(userID).snapshots().forEach((element) {
        var cartDetails = CartDetails();
        cartDetails = CartDetails.fromDoc(element);
        order.set(cartDetails.toDoc(orderID));
      });
    } catch (e) {
      print(e);
    }
  }
  // var cartSnap = cartRef.doc(userID).collection('cart_items').snapshots();
  // var orderSnap = orderRef.doc(orderID).collection('orderItems');
  // var order = orderRef.doc(orderID);
  // var cartItem = CartItem();
  // var cartItems = <CartItem>[];
  // cartSnap.map((event) async {
  //   event.docs.forEach((element) async {
  //     cartItem = CartItem.fromDoc(element);
  //     cartItems.add(cartItem);
  //     for (int i = 0; i < cartItems.length; i++) {
  //       await orderSnap.doc(cartItems[i].id).set(
  //             cartItem.toDocWithValue(
  //               id: cartItems[i].id,
  //               title: cartItems[i].title,
  //               servicesName: cartItems[i].servicesName,
  //               serviceCategory: cartItems[i].serviceCategory,
  //               servicePrice: cartItems[i].servicePrice,
  //               serviceValue: cartItems[i].serviceValue,
  //               quantity: cartItems[i].quantity,
  //             ),
  //           );
  //       break;
  //     }
  //   });
  // }).toList();

  // // try {
  // //   cartSnap.map((event) async {
  // //     event.docs.forEach((element) async {

  // //       print(cartItems);
  // //     });
  // //   }).toList();

  // cartRef.doc(userID).snapshots().forEach((element) {
  //   var cartDetails = CartDetails();
  //   cartDetails = CartDetails.fromDoc(element);
  //   order.set(cartDetails.toDoc(orderID));
  // });
  // // } catch (e) {
  // //   print(e);
  // // }

  updateCartDetails(
      {@required String userID, Map<String, dynamic> cartDetails}) async {
    try {
      await cartApi.cartRef.doc(userID).update(cartDetails);
    } catch (e) {
      print(e);
    }
  }
}
