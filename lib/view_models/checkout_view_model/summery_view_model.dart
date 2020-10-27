import 'dart:math';
import 'package:casanova/services/checkout_api/checkout_api.dart';
import 'package:casanova/ui/views/chackout_view/summery_page/widget/sent_order_dialog.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';

import '../base_view_model.dart';

class SummeryViewModel extends BaseViewModel {
  final checkOutApi = GetIt.I.get<CheckoutApi>();
  var orderIDGenerator = Random();
  String orderID;

  orderId() {
    var id = orderIDGenerator.nextInt(92143543) + 09451234356;
    var randomId = "MD-${id.toString().substring(0, 8)}";
    orderID = randomId;
    notifyListeners();
  }

  postOrder(context, {@required String userID}) async {
    orderId();
    await checkOutApi.sendAllCartItemsToOrder(userID: userID, orderID: orderID);
    Navigator.of(context).push(OrderSentOverlay(orderID));
    orderID = '';
    clearCartItems(userID);
    notifyListeners();
  }

  clearCartItems(String userID) async {
    await checkOutApi.clearCart(userID: userID);
  }
}
