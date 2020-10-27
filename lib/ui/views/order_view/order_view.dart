import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import '../../../model/orders/orders.dart';
import '../../../services/auth_api/auth_api.dart';
import '../../../services/order_api/order_api.dart';
import '../../../ui/views/drawer_view/widgets/second_app_bar.dart';
import '../../../ui/views/widgets/badge_with_value.dart';
import '../../../view_models/theme_view_model/theme_model.dart';
import 'order_status.dart';

class OrdersView extends StatelessWidget {
  final String title;
  final bool isRateNReviewClicked;

  OrdersView({Key key, this.title, this.isRateNReviewClicked})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title == null ? 'Orders' : title),
        actions: [
          BadgeWithValue(),
        ],
      ),
      body: Order(isRateNReviewClicked: isRateNReviewClicked),
    );
  }
}

class Order extends StatelessWidget {
  Order({
    Key key,
    @required this.isRateNReviewClicked,
  }) : super(key: key);

  final bool isRateNReviewClicked;
  final userApi = GetIt.I.get<AuthApi>();

  @override
  Widget build(BuildContext context) {
    final user = userApi.users;
    return Container(
      child: Column(
        children: [
          SecondAppBar(
            isTrailingWid: false,
            leadingText: 'MY ORDER HISTORY',
          ),
          Consumer<OrderApi>(builder: (context, orderApi, child) {
            return Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: orderApi.getUserOrder(user.userID),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }

                    var doc = snapshot.data.docs;
                    var order = Orders();
                    var orders = <Orders>[];

                    doc.map((e) {
                      order = Orders.fromDoc(e);
                      orders.add(order);
                    }).toList();

                    if (orders.isEmpty) {
                      return Center(
                        child: Text('Empty Order\nYour orders will appear here',
                            textAlign: TextAlign.center),
                      );
                    }

                    return Container(
                      child: ListView.separated(
                        separatorBuilder: (ctx, i) {
                          return Divider();
                        },
                        itemCount: orders.length,
                        itemBuilder: (ctx, i) {
                          var kOrders = orders[i];
                          return ListTile(
                              title: Text(
                                '${kOrders.orderID}',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              subtitle: Text(
                                '${kOrders.pickUpTime}',
                                style: TextStyle(color: grey500),
                              ),
                              trailing: Text(
                                '₦${kOrders.totalAmount}',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              onTap: () =>
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => OrderStatus(
                                            isRateNReviewClicked:
                                                isRateNReviewClicked,
                                            user: user,
                                            orders: kOrders,
                                          ))));
                        },
                      ),
                    );
                  }),
            );
          })
        ],
      ),
    );
  }
}
