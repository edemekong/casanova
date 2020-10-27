import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../../../../../images_assets/images_assets.dart';
import '../../../../../ui/commons/sizes.dart';
import '../../../../../ui/views/start_view/auth_page/widgets/already_have_acct.dart';
import '../../../../../ui/views/start_view/auth_page/widgets/build_or_divider.dart';
import '../../../../../ui/views/start_view/auth_page/widgets/logo_title_subtitle.dart';
import '../../../../../ui/views/start_view/auth_page/widgets/social_media_icons.dart';
import '../../../../../ui/views/widgets/button.dart';
import '../../../../../ui/views/widgets/text_field_wid.dart';
import '../../../../../view_models/start_view_model/auth_view_model/auth_view_model.dart';
import '../../../../../view_models/start_view_model/auth_view_model/login_view_model.dart';

class Login extends StatelessWidget {
  final onTapSignUp;
  final GlobalKey<ScaffoldState> scaffoldKey;
  const Login({Key key, this.onTapSignUp, this.scaffoldKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var loginViewModel = Provider.of<LoginViewModel>(context);
    return Form(
      key: AuthViewModel.loginFormKey,
      child: TweenAnimationBuilder(
        duration: Duration(milliseconds: 500),
        tween: Tween<double>(begin: 0, end: 1),
        builder: (context, val, child) {
          return Opacity(
              opacity: val,
              child: Padding(
                padding: EdgeInsets.only(top: val * 50),
                child: child,
              ));
        },
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            child: Column(
              children: [
                LogoWithTitleAndSubtitle(
                  imageUrl: Image.asset(ImageAssets.logo),
                  title: 'Login',
                  subtitle: 'Welcome back, login to continue...',
                ),
                sizedBoxHeight12,
                TextFieldWidRounded(
                  title: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  controller: loginViewModel.email,
                  validator: AuthViewModel.validateEmail,
                ),
                TextFieldWidRounded(
                  title: 'Password',
                  obscureText: loginViewModel.isVisiblePassword ? true : false,
                  maxLine: 1,
                  // onTapVisibilityIcon: loginViewModel.onChangeVisibility(),
                  keyboardType: TextInputType.visiblePassword,
                  controller: loginViewModel.passwordController,
                  validator: AuthViewModel.validatePass,
                  suffixIcon: Icon(loginViewModel.isVisiblePassword
                      ? Icons.visibility_off
                      : Icons.visibility_rounded),
                ),
                sizedBoxHeight16,
                GradiantButton(
                  title: 'Login',
                  isOutline: false,
                  buttonState: loginViewModel.buttonState,
                  onPressed: () {
                    loginViewModel.handleSubmit(context);
                    // return Navigator.push(
                    //     context, MaterialPageRoute(builder: (ctx) => HomePage()));
                  },
                ),
                sizedBoxHeight16,
                AlreadyHaveAnAccountCheck(
                  onTapForgotPassword: () {
                    print('tapped');
                    scaffoldKey.currentState.showBottomSheet((context) =>
                        _bottomSheetContent(context,
                            loginViewModel: loginViewModel));
                  },
                  login: true,
                  onPressed: onTapSignUp,
                ),
                sizedBoxHeight24,
                sizedBoxHeight24,
                OrDivider(),
                _socialMediaButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _bottomSheetContent(context, {LoginViewModel loginViewModel}) {
    return IntrinsicHeight(
      child: Container(
        height: MediaQuery.of(context).size.height / 1.5,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.6),
              spreadRadius: 500,
              blurRadius: 70,
            ),
          ],
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Form(
          key: AuthViewModel.resetFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LogoWithTitleAndSubtitle(
//            imageUrl: Image.asset(ImageAssets.logo),
                title: 'Reset Password',
                subtitle: 'Enter email to reset password...',
              ),
              sizedBoxHeight16,
              TextFieldWidRounded(
                title: 'Email',
                controller: loginViewModel.email,
                validator: AuthViewModel.validateEmail,
              ),
              sizedBoxHeight16,
              GradiantButton(
                isOutline: false,
                title: 'Reset Password',
                onPressed: loginViewModel.isLoadingReset
                    ? null
                    : () {
                        loginViewModel.handleSubmitForPasswordReset(context);
                        // return Navigator.push(
                        //     context, MaterialPageRoute(builder: (ctx) => HomePage()));
                      },
              ),
              sizedBoxHeight24,
            ],
          ),
        ),
      ),
    );
  }

  Row _socialMediaButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialMediaIcon(
          iconSrc: 'assets/images/g_icon.png',
        ),
        SocialMediaIcon(
          iconSrc: 'assets/images/fb_icon.png',
        ),
      ],
    );
  }
}
