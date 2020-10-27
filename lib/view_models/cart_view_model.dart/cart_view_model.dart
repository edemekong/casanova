import 'package:casanova/services/cart_api/cart_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../base_view_model.dart';

class CartViewModel extends BaseViewModel {
  final cartApi = GetIt.I.get<CartApi>();

  Stream<QuerySnapshot> getAllServiceInCart({@required String userID}) async* {
    try {
      yield* cartApi.getAllServiceInCart(userID: userID);
    } catch (e) {}
  }

  Future<int> getServiceAddedQtyCount(
      {@required String userID, @required String id}) async {
    var cart = await cartApi.cartRef
        .doc(userID)
        .collection('cart_items')
        .doc(id)
        .get();
    final value = await cart.data()['quantity'];
    return value ?? 0;
  }

  Future<void> updateCartDetail(
      {@required String userID,
      @required int deliveryFee,
      @required String pickUpTime,
      @required int totalAmount,
      @required int totalItemCount,
      @required double totalValue,
      @required String deliveryTime}) async {
    try {
      await cartApi.updateCartDetail(
          userID: userID,
          deliveryFee: deliveryFee,
          pickUpTime: pickUpTime,
          totalAmount: totalAmount,
          totalItemCount: totalItemCount,
          totalValue: totalValue,
          deliveryTime: deliveryTime);
    } catch (e) {}
  }

  Future<void> addServiceToCart(context,
      {@required String userID,
      String id,
      String title,
      String category,
      String subCategory,
      int servicePrice,
      double serviceValue}) async {
    await getServiceAddedQtyCount(userID: userID, id: id);
    await cartApi.addServiceToCart(context,
        userID: userID,
        id: id,
        title: title,
        category: category,
        subCategory: subCategory,
        servicePrice: servicePrice,
        serviceValue: serviceValue);
  }

  Future<void> removeSingleServiceFromCart(context,
      {@required String userID,
      String id,
      String title,
      String category,
      String subCategory,
      int servicePrice,
      double serviceValue}) async {
    try {
      await cartApi.removeSingleServiceFromCart(context,
          userID: userID,
          id: id,
          title: title,
          category: category,
          subCategory: subCategory,
          servicePrice: servicePrice,
          serviceValue: serviceValue);
    } catch (e) {}
  }

  Future<void> removeServiceFromCart(
    context, {
    @required String userID,
    String id,
  }) async {
    try {
      await cartApi.removeServiceFromCart(context, userID: userID, id: id);
    } catch (e) {}
  }
}
