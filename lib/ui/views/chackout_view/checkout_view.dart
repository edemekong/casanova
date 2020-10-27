import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'delivery_page/delvery_page.dart';
import '../../../ui/views/chackout_view/payment_page/payment.dart';
import '../../../ui/views/chackout_view/summery_page/summery.dart';
import '../../../view_models/checkout_view_model/checkout_model.dart';
import '../../../view_models/checkout_view_model/delivery_view_model.dart';
import '../../../view_models/theme_view_model/theme_model.dart';
import '../../../model/cart/cart_items.dart';

import '../../../services/auth_api/auth_api.dart';

class CheckoutView extends StatefulWidget {
  final List<CartItem> cartItems;

  const CheckoutView({Key key, this.cartItems}) : super(key: key);
  @override
  _CheckoutViewState createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  final authApi = GetIt.I.get<AuthApi>();

  @override
  Widget build(BuildContext context) {
    return CheckoutInjector(
      child: Builder(
        builder: (context) {
          final model = Provider.of<CheckoutModel>(context);
          final deliveryViewModel = Provider.of<DeliveryViewModel>(context);
          final check = deliveryViewModel.dateTime == null &&
              deliveryViewModel.timeOfDay == null &&
              deliveryViewModel.deliveryTime == null;

          return Scaffold(
            appBar: AppBar(
              title: Text('CHECKOUT'),
              centerTitle: true,
              backgroundColor: Colors.blue[100].withOpacity(.2),
              elevation: 0,
            ),
            body: Container(
              color: Colors.blue[100].withOpacity(.2),
              child: Column(
                children: [
                  Container(
                    color: Colors.orange,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: model.pageIndex == 0
                                ? null
                                : () => model.onTap(--model.pageIndex)),
                        IconButton(
                          icon: Icon(Icons.arrow_forward),
                          onPressed: (model.pageIndex == 2)
                              ? null
                              : check
                                  ? () => model.onTap(
                                        ++model.pageIndex,
                                      )
                                  : null,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: PageView(
                      scrollDirection: Axis.horizontal,
                      controller: model.pageController,
                      onPageChanged: model.onPageChanged,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        DeliveryPage(
                          onTap: model.onTap,
                          cartItems: widget.cartItems,
                          user: authApi.users,
                        ),
                        PaymentPage(
                          onTap: model.onTap,
                          user: authApi.users,
                        ),
                        SummeryPage(
                          user: authApi.users,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  //todo paulV why the need of a custom tabber I dont understand pls write down an explanation for this

  FlatButton tabberButton(BuildContext context,
      {String buttonTitle, Function() onTap, bool setButton}) {
    return FlatButton(
        color: setButton ? primaryButtonColor : grey200,
        textColor: setButton ? white : grey400,
        onPressed: onTap,
        child: Text(buttonTitle));
  }
}

class CheckoutInjector extends StatefulWidget {
  final Widget child;

  CheckoutInjector({@required this.child});

  @override
  _CheckoutInjectorState createState() => _CheckoutInjectorState();
}

class _CheckoutInjectorState extends State<CheckoutInjector> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CheckoutModel(),
      child: widget.child,
    );
  }
}
