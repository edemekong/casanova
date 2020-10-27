import 'package:casanova/view_models/start_view_model/landing_view_model/start_view_model.dart';
import 'package:flutter/material.dart';
import '../../../../ui/views/start_view/auth_page/widgets/show_alert.dart';
import '../../../../view_models/start_view_model/auth_view_model/login_view_model.dart';
import '../../../../view_models/start_view_model/auth_view_model/sign_up_view_model.dart';
import 'package:provider/provider.dart';
import 'login_page/login.dart';
import 'signin/sign_up.dart';
import 'widgets/custom_curves.dart';

class SignUpLogin extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return StartPageInjector(
      child: Builder(builder: (context) {
        final model = Provider.of<StartPageViewModel>(context);
        final loginViewModel = Provider.of<LoginViewModel>(context);
        final signUpViewModel = Provider.of<SignUpViewModel>(context);

        return Scaffold(
          key: scaffoldKey,
          body: Stack(
            children: [
              CustomPaint(
                painter: CurvePainter(),
                child: Container(),
              ),
              RotatedBox(
                quarterTurns: -2,
                child: CustomPaint(
                  painter: CurvePainterUp(),
                  child: Container(),
                ),
              ),
              Container(
                color: Colors.blue[100].withOpacity(.1),
                child: Container(
                  child: PageView(
                    scrollDirection: Axis.horizontal,
                    controller: model.pageController,
                    physics: NeverScrollableScrollPhysics(),
                    onPageChanged: model.onPageChanged,
                    children: [
                      Login(
                        onTapSignUp: () => model.onTapChangePageView(1),
                        scaffoldKey: scaffoldKey,
                      ),
                      SignUp(onTapLogin: () => model.onTapChangePageView(0)),
                    ],
                  ),
                ),
              ),
              SafeArea(
                  child: ShowAlert(
                warning: loginViewModel.alertMessage,
                viewModel: loginViewModel,
              )),
              SafeArea(
                  child: ShowAlert(
                warning: signUpViewModel.alertMessage,
                viewModel: signUpViewModel,
              )),
            ],
          ),
        );
      }),
    );
  }
}

class StartPageInjector extends StatefulWidget {
  final Widget child;

  StartPageInjector({@required this.child});

  @override
  _StartPageInjectorState createState() => _StartPageInjectorState();
}

class _StartPageInjectorState extends State<StartPageInjector> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StartPageViewModel(),
      child: widget.child,
    );
  }
}
