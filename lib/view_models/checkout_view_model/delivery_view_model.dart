import 'package:casanova/model/user/user.dart';
import 'package:casanova/services/checkout_api/checkout_api.dart';
import 'package:casanova/ui/views/widgets/snacks.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../base_view_model.dart';

class DeliveryViewModel extends BaseViewModel {
  final checkOutApi = GetIt.I.get<CheckoutApi>();
  String dateTime;
  String timeOfDay;

  String deliveryTime = '';
  String initialHowOftenValue = 'One Time only';

  Map<String, bool> timeCheck = {
    'Tomorrow': false,
    '2 to 3 days': false,
  };

  List<HowOften> howOftenItems = [
    HowOften(
      value: 'One Time only',
    ),
    HowOften(
      value: 'In Every Three Days',
    ),
    HowOften(
      value: 'Weekly',
    ),
    HowOften(
      value: 'Bi-Weekly',
    ),
    HowOften(
      value: 'Monthly',
    ),
  ];

  setHowOften(context, String value, Users user) async {
    initialHowOftenValue = value;
    notifyListeners();
    await checkOutApi.updateCartDetails(
        userID: user.userID, cartDetails: {'howOften': initialHowOftenValue});
    showSnackbar(context,
        msg: 'How Often set to:\n$initialHowOftenValue',
        icon: Icons.how_to_reg);
  }

  setDateTime(context, Users user) async {
    await setDate(context);
    await setTime(context);
    await setPickUpTime(user.userID, timeOfDay + ' || ' + dateTime);
    showSnackbar(context,
        msg: 'Pick-up time set to:\n${timeOfDay + ' || ' + dateTime}',
        icon: Icons.alarm_on);
  }

  setDate(context) async {
    var date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2023),
    );
    dateTime = date.toString().substring(0, 11);
    notifyListeners();
  }

  setTime(context) async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    timeOfDay = time.format(context);
    showSnackbar(context,
        msg: 'Pick-up day set', icon: Icons.calendar_view_day);

    notifyListeners();
  }

  setPickUpTime(String userID, data) {
    checkOutApi
        .updateCartDetails(userID: userID, cartDetails: {'pickUpTime': data});
    notifyListeners();
  }

  setDeliveryTimeTomorrow(context, {String userID, bool value}) {
    if (value) {
      timeCheck['Tomorrow'] = value;
      timeCheck['2 to 3 days'] = false;
      deliveryTime = timeCheck.keys.first;
      checkOutApi.updateCartDetails(userID: userID, cartDetails: {
        'deliveryTime': deliveryTime,
      });
      showSnackbar(context,
          msg: 'Drop-off Time set to:\nTomorrow', icon: Icons.delivery_dining);
      notifyListeners();
    } else {
      timeCheck['Tomorrow'] = value;
      deliveryTime = timeCheck.keys.last;
      checkOutApi.updateCartDetails(
          userID: userID, cartDetails: {'deliveryTime': deliveryTime});

      notifyListeners();
    }
  }

  setDeliveryTimeDays(context, {String userID, bool value}) {
    if (value) {
      timeCheck['2 to 3 days'] = value;
      timeCheck['Tomorrow'] = false;
      deliveryTime = timeCheck.keys.last;
      print(deliveryTime);
      checkOutApi.updateCartDetails(
          userID: userID, cartDetails: {'deliveryTime': deliveryTime});
      showSnackbar(context,
          msg: 'Drop-off Time/Day set to:\n2 to 3 days',
          icon: Icons.delivery_dining);
      notifyListeners();
    } else {
      timeCheck['2 to 3 days'] = value;
      deliveryTime = timeCheck.keys.first;
      print(deliveryTime);
      checkOutApi.updateCartDetails(
          userID: userID, cartDetails: {'deliveryTime': deliveryTime});
      notifyListeners();
    }
  }
}

class HowOften {
  final String id;
  final String value;

  HowOften({this.id, this.value});
}
