import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../../services/ads_api/ads_api.dart';
import '../../services/cart_api/cart_api.dart';
import '../../services/checkout_api/checkout_api.dart';
import '../../services/faq_api/faq_api.dart';
import '../../services/order_api/order_api.dart';
import '../../services/product_api/product_api.dart';
import '../../view_models/ads_view_model.dart/ads_view_model.dart';
import '../../view_models/cart_view_model.dart/cart_view_model.dart';
import '../../view_models/checkout_view_model/delivery_view_model.dart';
import '../../view_models/checkout_view_model/summery_view_model.dart';
import '../../view_models/drawer_view_model/drawer_view_model.dart';
import '../../view_models/home_view_model/home_view_model.dart';
import '../../view_models/profile_view_model/profile_view_model.dart';
import '../.././view_models/rate_review_model/rate_review_model.dart';
import '../../view_models/theme_view_model/theme_model.dart';

import '../../././view_models/start_view_model/auth_view_model/login_view_model.dart';
import '../../././view_models/start_view_model/auth_view_model/sign_up_view_model.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider.value(value: AdsApi()),
  ChangeNotifierProvider.value(value: AdsViewModel()),
  ChangeNotifierProvider.value(value: DeliveryViewModel()),
  ChangeNotifierProvider.value(value: FaqApi()),
  ChangeNotifierProvider.value(value: CheckoutApi()),
  ChangeNotifierProvider.value(value: HomeViewModel()),
  ChangeNotifierProvider.value(value: SummeryViewModel()),
  ChangeNotifierProvider.value(value: ThemeModel()),
  ChangeNotifierProvider.value(value: SignUpViewModel()),
  ChangeNotifierProvider.value(value: LoginViewModel()),
  ChangeNotifierProvider.value(value: CartApi()),
  ChangeNotifierProvider.value(value: OrderApi()),
  ChangeNotifierProvider.value(value: RateReviewModel()),
  ChangeNotifierProvider.value(value: ProfileViewModel()),
  ChangeNotifierProvider.value(value: DrawerViewModel()),
  ChangeNotifierProvider.value(value: CartViewModel()),
  ChangeNotifierProvider.value(value: ProductApi()),
];
