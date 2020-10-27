import 'package:casanova/services/order_api/order_api.dart';
import 'package:get_it/get_it.dart';

import '../base_view_model.dart';

class OrderviewModel extends BaseViewModel {
  var orderApi = GetIt.I.get<OrderApi>();
}
