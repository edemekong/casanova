import 'package:casanova/services/auth_api/auth_api.dart';
import 'package:casanova/ui/views/home_view/home_view.dart';
import 'package:casanova/ui/views/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../base_view_model.dart';
import 'auth_view_model.dart';

class SignUpViewModel extends BaseViewModel implements AuthViewModel {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController confirmPass = TextEditingController();
  ButtonState buttonState = ButtonState.Initial;

  @override
  TextEditingController emailController = TextEditingController();
  @override
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  String alertMessage = '';

  var signApi = GetIt.I.get<AuthApi>();

  @override
  void clearFields() {
    firstName.clear();
    lastName.clear();
    phone.clear();
    confirmPass.clear();
    emailController.clear();
    confirmPass.clear();
  }

  String validateConfirmPass(String value) {
    if (value.isEmpty) {
      return 'Passord can\'t be empty';
    } else if (value.trim() == passwordController.text.trim()) {
      return null;
    }
    return 'Password does not match';
  }

  handleSubmit(BuildContext context) async {
    final form = AuthViewModel.signupFormKey.currentState;
    isLoading = true;
    // await Future.delayed(Duration(seconds: 10));
    buttonState = ButtonState.Loading;

    if (form.validate()) {
      print('validated');

      try {
        isLoading = true;
        buttonState = ButtonState.Loading;

        notifyListeners();
        await signApi.signUpUser(
            email: emailController.text,
            firstName: firstName.text,
            lastName: lastName.text,
            password: passwordController.text,
            phone: phone.text);
        alertMessage =
            'Successfully created User ${signApi.users.email}, Welcome!!';
        notifyListeners();

        buttonState = ButtonState.Initial;
        await Future.delayed(Duration(seconds: 3));
        isLoading = false;

        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (ctx) => HomeView()));
        alertMessage = '';
        notifyListeners();
      } catch (e) {
        alertMessage =
            'Failed Creating User ${emailController.text}, Try again!! [${e.message.toUpperCase()}]';
        notifyListeners();
        print(e);
      }
    } else {
      print('Not validated');
      Future.delayed(Duration(seconds: 2), () {
        buttonState = ButtonState.Initial;

        isLoading = false;
        notifyListeners();
      });
    }
    notifyListeners();
  }

  siginwithGoogle() async {
    print('running');
    signApi.signInWithGoogle();
    alertMessage = signApi.message;
  }

  siginwithFacebook() {
    print('running');
    // authService.loginWithFacebook();
  }
}
