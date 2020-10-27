import 'package:casanova/services/ads_api/ads_api.dart';
import 'package:casanova/services/auth_api/auth_api.dart';
import 'package:casanova/services/cart_api/cart_api.dart';
import 'package:casanova/services/checkout_api/checkout_api.dart';
import 'package:casanova/services/order_api/order_api.dart';
import 'package:casanova/services/rate_review_api/rate_review_api.dart';
import 'package:casanova/services/user_api/user_api.dart';
import 'package:get_it/get_it.dart';

void setup() {
  GetIt.I.registerSingleton<CartApi>(CartApi());
  GetIt.I.registerSingleton<CheckoutApi>(CheckoutApi());
  GetIt.I.registerSingleton<AuthApi>(AuthApi());
  GetIt.I.registerSingleton<UserApi>(UserApi());
  GetIt.I.registerSingleton<OrderApi>(OrderApi());
  GetIt.I.registerSingleton<AdsApi>(AdsApi());
  GetIt.I.registerSingleton<RateReviewApi>(RateReviewApi());
}
