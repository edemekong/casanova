import 'package:flutter/material.dart';
import '../../../model/orders/orders.dart';
import '../../../model/user/user.dart';
import '../../../ui/commons/sizes.dart';
import '../../../ui/views/drawer_view/widgets/second_app_bar.dart';
import '../../../ui/views/order_view/review_rate.dart';
import '../../../ui/views/order_view/service_items.dart';
import '../../../ui/views/widgets/badge_with_value.dart';
import '../../../ui/views/widgets/button.dart';
import '../../../view_models/theme_view_model/theme_model.dart';

class OrderStatus extends StatefulWidget {
  final bool isRateNReviewClicked;
  final Orders orders;
  final Users user;

  OrderStatus({Key key, this.isRateNReviewClicked, this.orders, this.user})
      : super(key: key);

  @override
  _OrderStatusState createState() => _OrderStatusState();
}

class _OrderStatusState extends State<OrderStatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Order Status'),
          actions: [
            BadgeWithValue(),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                _orderStatus(context),
                widget.isRateNReviewClicked == null ||
                        widget.isRateNReviewClicked
                    ? ReviewRateService(
                        orderID: widget.orders.orderID,
                        users: widget.user,
                      )
                    : Container(),
              ],
            ),
          ),
        ));
  }

  Column _orderStatus(BuildContext context) {
    final order = widget.orders;
    final user = widget.user;

    return Column(
      children: [
        SecondAppBar(
          isTrailingWid: false,
          leadingText: '${order.orderID}',
          trailingText: '${order.pickUpTime}',
        ),
        Container(
          child: Column(
            children: [
              Row(
                children: [
                  _exListTile(
                    context,
                    title: '${order.totalItemCount} item Count',
                    subtitle: 'N200',
                  ),
                  _exListTile(
                    context,
                    title: 'Payment',
                    subtitle: 'Pay On Delivery',
                  ),
                ],
              ),
              Divider(),
              Row(
                children: [
                  _exListTile(
                    context,
                    title: 'Delivering To:',
                    subtitle:
                        '${user.fullName}\n${user.address},\n+${user.phone}',
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                        text: 'STATUS:    ',
                        style: TextStyle(
                          color: black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      WidgetSpan(
                          style: TextStyle(height: 6),
                          child: Chip(
                              backgroundColor: primaryColor,
                              label: Text('${order.status}'))),
                    ])),
                  ),
                ],
              ),
              sizedBoxHeight16,
              GradiantButton(
                  isOutline: false,
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => ServiceItems(
                            orderID: order.orderID,
                          ))),
                  title: 'View Services in these Order'),
              sizedBoxHeight16,
            ],
          ),
        ),
      ],
    );
  }

  Expanded _exListTile(BuildContext context, {String subtitle, String title}) {
    return Expanded(
      child: ListTile(
        title: Text(title),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: grey500),
        ),
      ),
    );
  }
}
