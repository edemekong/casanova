import 'package:flutter/material.dart';

import '../base_view_model.dart';

class ThemeModel extends BaseViewModel {
  bool isDarkTheme = false;

  ThemeData theme = ThemeData(
      primaryColor: primaryColor,
      accentColor: secondaryColor,
      buttonColor: Colors.orange,
      scaffoldBackgroundColor: Color(0xFFF5FFFF),
      fontFamily: 'Poppins-Regular',
      appBarTheme: AppBarTheme(elevation: 0, color: Colors.transparent));
}

Color primaryColor = Colors.blue[200];
Color secondaryColor = Colors.orange;

Color primaryButtonColor = secondaryColor;
Color secondaryButtonColor = grey300;
Color white = Colors.white;
Color black = Colors.black;

Color grey200 = Colors.grey[200];

Color grey300 = Colors.grey[300];
Color grey400 = Colors.grey[400];
Color grey600 = Colors.grey[600];
Color grey500 = Colors.grey[500];

Color grey800 = Colors.grey[800];
