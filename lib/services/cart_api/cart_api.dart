import 'package:casanova/model/cart/cart_items.dart';
import 'package:casanova/ui/views/widgets/snacks.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../model/orders/orders.dart';

class CartApi extends ChangeNotifier {
  var cartRef = FirebaseFirestore.instance.collection('users_cart');

  Future<void> updateCartDetail(
      {@required String userID,
      @required int deliveryFee,
      @required String pickUpTime,
      @required int totalAmount,
      @required int totalItemCount,
      @required double totalValue,
      @required String deliveryTime}) async {
    var order = Orders();
    await cartRef.doc(userID).update(order.toDoc(
          userID: userID,
          deliveryFee: deliveryFee,
          deliveryTime: deliveryTime,
          pickUpTime: pickUpTime,
          totalAmount: totalAmount,
          totalItemCount: totalItemCount,
          totalValue: totalValue,
        ));
  }

  Stream<QuerySnapshot> getAllServiceInCart({@required String userID}) async* {
    yield* cartRef.doc(userID).collection('cart_items').snapshots();
  }

  Future<void> removeServiceFromCart(context,
      {@required String userID, @required String id}) async {
    await cartRef.doc(userID).collection('cart_items').doc(id).delete();
  }

  Future<int> getServiceAddedQtyCount(
      {@required String userID, @required String id}) async {
    var cart = await cartRef.doc(userID).collection('cart_items').doc(id).get();
    final value = await cart.data()['quantity'];
    return value ?? 0;
  }

  addServiceToCart(context,
      {@required String userID,
      @required String id,
      @required String title,
      @required String category,
      @required String subCategory,
      @required int servicePrice,
      @required double serviceValue}) async {
    final doc =
        await cartRef.doc(userID).collection('cart_items').doc(id).get();
    var cartItem = CartItem();
    cartItem.id = id;
    cartItem.title = title;
    cartItem.servicePrice = servicePrice;
    cartItem.newServicePrice = servicePrice;
    cartItem.category = category;
    cartItem.serviceValue = serviceValue;
    cartItem.subCategory = subCategory;
    var order = Orders();
    notifyListeners();

    if (doc.exists) {
      cartItem = CartItem.fromDoc(doc);
      final newQuantity = cartItem.quantity + 1;
      final newPrice = cartItem.servicePrice + cartItem.newServicePrice;
      final newValue = serviceValue * newQuantity;

      notifyListeners();

      await cartRef
          .doc(userID)
          .collection('cart_items')
          .doc(cartItem.id)
          .update(cartItem.toDocWithValue(
            id: cartItem.id,
            title: cartItem.title,
            subCategory: cartItem.subCategory,
            category: cartItem.category,
            quantity: newQuantity,
            servicePrice: cartItem.servicePrice,
            newServicePrice: newPrice,
            serviceValue: newValue,
          ));
      showSnackbarTop(context,
          msg: 'Added, ${cartItem.title} to Cart', quantity: 'x$newQuantity');
    } else {
      await cartRef
          .doc(userID)
          .collection('cart_items')
          .doc(cartItem.id)
          .set(cartItem.toDoc());
      await cartRef.doc(userID).set(order.toDoc());
      showSnackbarTop(context,
          msg: 'Added, ${cartItem.title} to Cart', quantity: 'x1');

      notifyListeners();
    }
    notifyListeners();
  }

  Future<void> removeSingleServiceFromCart(context,
      {@required String userID,
      @required String id,
      @required String title,
      @required String category,
      @required String subCategory,
      @required int servicePrice,
      @required double serviceValue}) async {
    final doc =
        await cartRef.doc(userID).collection('cart_items').doc(id).get();
    var cartItem = CartItem();
    cartItem.id = id;
    cartItem.title = title;
    cartItem.servicePrice = servicePrice;
    cartItem.newServicePrice = servicePrice;
    cartItem.category = category;
    cartItem.serviceValue = serviceValue;
    cartItem.subCategory = subCategory;
    var order = Orders();
    notifyListeners();

    if (doc.exists) {
      cartItem = CartItem.fromDoc(doc);
      final newQuantity = cartItem.quantity - 1;
      final newPrice = cartItem.newServicePrice - cartItem.servicePrice;
      final newValue = serviceValue * newQuantity;

      notifyListeners();
      if (cartItem.quantity <= 1) {
        await removeServiceFromCart(context, userID: userID, id: id);
        showSnackbarTop(context,
            msg: 'Removed, ${cartItem.title} from Cart',
            quantity: 'x$newQuantity');
      } else {
        await cartRef
            .doc(userID)
            .collection('cart_items')
            .doc(cartItem.id)
            .update(cartItem.toDocWithValue(
              id: cartItem.id,
              title: cartItem.title,
              subCategory: cartItem.subCategory,
              category: cartItem.category,
              quantity: newQuantity,
              newServicePrice: newPrice,
              servicePrice: servicePrice,
              serviceValue: newValue,
            ));
        showSnackbarTop(context,
            msg: 'Removed, ${cartItem.title} from Cart',
            quantity: 'x$newQuantity');
      }
    } else {
      await cartRef
          .doc(userID)
          .collection('cart_items')
          .doc(cartItem.id)
          .set(cartItem.toDoc());
      await cartRef.doc(userID).set(order.toDoc());
      showSnackbarTop(context,
          msg: 'Removed, ${cartItem.title} from Cart', quantity: 'x1');

      notifyListeners();
    }
    notifyListeners();
  }
}
