import 'package:casanova/model/orders/orders.dart';
import 'package:casanova/services/order_api/order_api.dart';
import 'package:casanova/ui/commons/sizes.dart';
import 'package:casanova/view_models/theme_view_model/theme_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServiceItems extends StatelessWidget {
  final String orderID;

  const ServiceItems({Key key, this.orderID}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: Text('Services'),
        ),
        body: Consumer<OrderApi>(
            builder: (BuildContext context, orderApi, Widget child) {
          return Column(
            children: [
              Container(
                color: Colors.yellow,
                height: 50,
                width: screenSize.width,
                padding: paddingAll16,
                child: Text('SERVICES IN YOUR ORDER',
                    style: TextStyle(fontWeight: FontWeight.w700)),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: orderApi.getOrderItems(orderID),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData &&
                            snapshot.connectionState != ConnectionState.done) {
                          return Center(
                            child: Text('Loading...'),
                          );
                        }
                        var doc = snapshot.data.docs;
                        var orderItem = OrderItems();
                        var orderItems = <OrderItems>[];
                        doc.map((e) {
                          orderItem = OrderItems.fromDoc(e);
                          orderItems.add(orderItem);
                        }).toList();
                        // print(orderItem.quantity);
                        return Container(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(orderItems.length, (i) {
                                  var kOrder = orderItems[i];
                                  return Builder(builder: (context) {
                                    return ListTile(
                                        title: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                  text:
                                                      '${kOrder.serviceName},',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              TextSpan(
                                                  text:
                                                      ' ₦${kOrder.servicePrice}\n',
                                                  style: TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              TextSpan(
                                                  text:
                                                      '${kOrder.servicesName}\n',
                                                  style: TextStyle(
                                                      color: grey500,
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                            ],
                                          ),
                                        ),
                                        trailing: Chip(
                                          label: Text(
                                              'Quantity: ${kOrder.quantity}'),
                                        ));
                                  });
                                })));
                      }),
                ),
              ),
            ],
          );
        }));
  }
}
