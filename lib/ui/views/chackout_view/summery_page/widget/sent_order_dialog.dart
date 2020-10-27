import 'package:casanova/ui/commons/sizes.dart';
import 'package:casanova/ui/utils/number_to_currency_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../services/order_api/order_api.dart';
import '../../../../../services/cart_api/cart_api.dart';

import '../../../../../model/orders/orders.dart';

class OrderSentOverlay extends ModalRoute<void> {
  final String orderID;

  OrderSentOverlay(this.orderID);
  @override
  Duration get transitionDuration => Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.card,
      color: Colors.blue[600].withOpacity(.6),
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: SingleChildScrollView(
          child: Consumer2<OrderApi, CartApi>(
              builder: (context, orderApi, cartApi, child) {
            return FutureBuilder<DocumentSnapshot>(
                future: orderApi.getOrder(orderID),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 10),
                        Text(
                          'Sending request...',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    );
                  }

                  var data = snapshot.data;
                  var order = Orders();
                  order = Orders.fromDoc(data);

                  return Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: Column(
                      children: <Widget>[
                        Material(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          child: PaddingAll16(
                            child: Column(
                              children: [
                                Text('Order Status',
                                    style: TextStyle(fontSize: 20)),
                                _rowWithWid(
                                  context,
                                  alignment: MainAxisAlignment.center,
                                  leading: Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                  ),
                                  trailing: Text(order.status.toString()),
                                ),
                                Divider(height: 30),
                                StreamBuilder<QuerySnapshot>(
                                    stream: orderApi.getOrderItems(orderID),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                          child: Text(
                                              'Retrieving all sent orders!!!'),
                                        );
                                      }
                                      var doc = snapshot.data.docs;
                                      var orderItem = OrderItems();
                                      var orderItems = <OrderItems>[];
                                      doc.map((e) {
                                        orderItem = OrderItems.fromDoc(e);
                                        orderItems.add(orderItem);
                                      }).toList();
                                      print(orderItem.quantity);
                                      return Column(
                                          children: List.generate(
                                              orderItems.length, (index) {
                                        var kOrderItems = orderItems[index];
                                        return Container(
                                          child: Column(
                                            children: [
                                              _rowWithWid(
                                                context,
                                                leading: Chip(
                                                  backgroundColor:
                                                      Colors.blue[200],
                                                  label: Text(
                                                      'Qty:${kOrderItems.quantity}'),
                                                ),
                                                trailing: RichText(
                                                    text: TextSpan(
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                        children: [
                                                      TextSpan(
                                                          text:
                                                              '${kOrderItems.serviceName}, ',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                      TextSpan(
                                                          text:
                                                              '${kOrderItems.servicesName}\n',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .grey[600],
                                                              fontSize: 14)),
                                                      TextSpan(
                                                          text:
                                                              '${kOrderItems.serviceCategory}',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .orange[900],
                                                              fontSize: 14)),
                                                    ])),
                                              ),
                                            ],
                                          ),
                                        );
                                      }));
                                    }),
                                Divider(height: 30),
                                _rowWithWid(context,
                                    alignment: MainAxisAlignment.center,
                                    leading: Text(
                                      'OrderID:',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    trailing: Text('${data.id}',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold))),
                                Divider(height: 30),
                                Text('Recieved on:   ${order.pickUpTime}'),
                                Text('Delivery Time:   ${order.deliveryTime}'),
                                sizedBoxHeight16,
                                Text(
                                  'Total:  ₦${convertNumberToCurrency(order.totalAmount)}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        sizedBoxHeight12,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FlatButton(
                              color: Colors.orange,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              onPressed: () async {
                                await cartApi.updateCartDetail(
                                  totalAmount: order.totalAmount,
                                  userID: order.userID,
                                  deliveryFee: order.deliveryFee,
                                  deliveryTime: order.deliveryTime,
                                  totalItemCount: order.totalItemCount,
                                  totalValue: order.totalValue,
                                  pickUpTime: order.pickUpTime,
                                );
                                Navigator.pop(context);
                              },
                              child: Text('Re-Order'),
                            ),
                            sizedBoxWidth16,
                            OutlineButton(
                              textColor: Colors.orange[200],
                              borderSide: BorderSide(
                                color: Colors.orange,
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              onPressed: () async {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: Text('Go Home'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                });
          }),
        ),
      ),
    );
  }

  Row _rowWithWid(BuildContext context,
      {Widget leading, Widget trailing, MainAxisAlignment alignment}) {
    return Row(
      mainAxisAlignment: alignment ?? MainAxisAlignment.start,
      children: [
        leading,
        sizedBoxWidth8,
        trailing,
      ],
    );
  }
}
