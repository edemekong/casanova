import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../images_assets/images_assets.dart';
import '../../../../../ui/commons/sizes.dart';
import '../../../../../ui/views/start_view/auth_page/widgets/already_have_acct.dart';
import '../../../../../ui/views/start_view/auth_page/widgets/build_or_divider.dart';
import '../../../../../ui/views/start_view/auth_page/widgets/logo_title_subtitle.dart';
import '../../../../../ui/views/start_view/auth_page/widgets/social_media_icons.dart';
import '../../../../../ui/views/widgets/button.dart';
import '../../../../../ui/views/widgets/text_field_wid.dart';
import '../../../../../view_models/start_view_model/auth_view_model/auth_view_model.dart';
import '../../../../../view_models/start_view_model/auth_view_model/sign_up_view_model.dart';

class SignUp extends StatelessWidget {
  final onTapLogin;

  const SignUp({Key key, this.onTapLogin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpViewModel>(builder: (context, signUpModel, child) {
      return Form(
        key: AuthViewModel.signupFormKey,
        child: TweenAnimationBuilder(
          duration: Duration(milliseconds: 500),
          tween: Tween<double>(begin: 0, end: 1),
          builder: (context, val, child) {
            return Opacity(
              opacity: val,
              child: Padding(
                padding: EdgeInsets.only(top: val * 50),
                child: child,
              ),
            );
          },
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: Column(
                children: [
                  LogoWithTitleAndSubtitle(
                    imageUrl: Image.asset(ImageAssets.logo),
                    title: 'Create Account',
                    subtitle: 'Welcome, create an account to continue...',
                  ),
                  sizedBoxHeight8,
                  Row(
                    children: [
                      Expanded(
                        child: TextFieldWidRounded(
                          title: 'First Name',
                          validator: AuthViewModel.validateName,
                          controller: signUpModel.firstName,
                          keyboardType: TextInputType.name,
                        ),
                      ),
                      Expanded(
                        child: TextFieldWidRounded(
                          title: 'Last Name',
                          validator: AuthViewModel.validateName,
                          controller: signUpModel.lastName,
                          keyboardType: TextInputType.name,
                        ),
                      ),
                    ],
                  ),
                  TextFieldWidRounded(
                    title: 'Phone',
                    validator: AuthViewModel.validatePhone,
                    controller: signUpModel.phone,
                    keyboardType: TextInputType.phone,
                  ),
                  TextFieldWidRounded(
                    title: 'Email',
                    controller: signUpModel.emailController,
                    validator: AuthViewModel.validateEmail,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextFieldWidRounded(
                    title: 'Password',
                    maxLine: 1,
                    suffixIcon: Icon(Icons.visibility_off),
                    controller: signUpModel.passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    validator: AuthViewModel.validatePass,
                  ),
                  TextFieldWidRounded(
                    title: 'Confirm Password',
                    maxLine: 1,
                    suffixIcon: Icon(Icons.visibility_off),
                    controller: signUpModel.confirmPass,
                    keyboardType: TextInputType.visiblePassword,
                    validator: signUpModel.validateConfirmPass,
                    obscureText: true,
                  ),
                  sizedBoxHeight8,
                  GradiantButton(
                    title: 'Create Account',
                    isOutline: true,
                    buttonState: signUpModel.buttonState,
                    onPressed: signUpModel.isLoading
                        ? null
                        : () => signUpModel.handleSubmit(context),
                  ),
                  AlreadyHaveAnAccountCheck(
                    login: false,
                    onPressed: onTapLogin,
                  ),
                  sizedBoxHeight8,
                  OrDivider(),
                  _socialMediaButtons(),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Consumer _socialMediaButtons() {
    return Consumer<SignUpViewModel>(
        builder: (context, signUpViewModel, child) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SocialMediaIcon(
            iconSrc: 'assets/images/g_icon.png',
            onPressed: () => signUpViewModel.siginwithGoogle(),
          ),
          SocialMediaIcon(
            iconSrc: 'assets/images/fb_icon.png',
            // onPressed: () => signUpViewModel.siginwithFacebook(),
          ),
        ],
      );
    });
  }
}
