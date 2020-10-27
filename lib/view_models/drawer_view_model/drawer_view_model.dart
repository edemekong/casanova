import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:casanova/model/layout_models/drawer_models.dart';
import 'package:casanova/services/auth_api/auth_api.dart';

import '../base_view_model.dart';

class DrawerViewModel extends BaseViewModel {
  final authApi = GetIt.I.get<AuthApi>();

  final List<DrawerButtonModels> accountButtons = [
    DrawerButtonModels(
      id: 'i0',
      buttonTitle: 'Orders',
      buttonColor: Colors.blue,
      leadingIcon: Icons.view_stream_outlined,
    ),
    DrawerButtonModels(
      id: 'i1',
      buttonTitle: 'Saved Items',
      buttonColor: Colors.orange,
      leadingIcon: Icons.favorite_border,
    ),
    DrawerButtonModels(
      id: 'i2',
      buttonTitle: 'Rate And Review',
      buttonColor: Colors.blue,
      leadingIcon: Icons.star_border,
    ),
    DrawerButtonModels(
      id: 'i2',
      buttonTitle: 'My Profile',
      buttonColor: Colors.blue,
      leadingIcon: Icons.person_outline,
    ),
    DrawerButtonModels(
      id: 'i3',
      buttonTitle: 'Contact',
      buttonColor: Colors.orange,
      leadingIcon: Icons.perm_phone_msg_outlined,
    ),
    DrawerButtonModels(
      id: 'i6',
      buttonTitle: 'Share App',
      buttonColor: Colors.orange,
      leadingIcon: Icons.share_outlined,
    ),
  ];

  final List<DrawerButtonModels> settingsButton = [
    DrawerButtonModels(
      id: 'i1',
      buttonTitle: 'Edit Profile',
    ),
    DrawerButtonModels(
      id: 'i2',
      buttonTitle: 'Settings',
    ),
  ];

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    }
    if (hour < 17) {
      return 'Afternoon';
    }
    return 'Evening';
  }
}
