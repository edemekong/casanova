import 'package:flutter/cupertino.dart';

class PickupAddressModel {
  final String id;
  final String title;
  final IconData icon;
  bool isButtonClicked;
  Color color;

  PickupAddressModel(
      {this.id, this.title, this.icon, this.isButtonClicked, this.color});
}
