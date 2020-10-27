import 'package:casanova/ui/utils/providers.dart';
import 'package:casanova/ui/views/start_view/auth_page/signup_login_views.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view_models/theme_view_model/theme_model.dart';

class Casanova extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: Builder(
        builder: (context) {
          return Consumer<ThemeModel>(builder: (context, theme, child) {
            return MaterialApp(
              title: 'Casanova Nigeria',
              debugShowCheckedModeBanner: false,
              theme: theme.theme,
              home: SignUpLogin(),
            );
          });
        },
      ),
    );
  }
}
