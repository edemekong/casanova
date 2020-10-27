import 'package:casanova/services/auth_api/auth_api.dart';
import 'package:casanova/ui/views/home_view/home_view.dart';
import 'package:casanova/ui/views/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../base_view_model.dart';
import 'auth_view_model.dart';

class LoginViewModel extends BaseViewModel with AuthViewModel {
  TextEditingController email = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ButtonState buttonState = ButtonState.Initial;
  bool isLoading = false;
  bool isLoadingReset = false;
  String alertMessage = '';
  bool isVisiblePassword = true;

  var loginApi = GetIt.I.get<AuthApi>();
  onChangeVisibility() {
    isVisiblePassword = !true;
    notifyListeners();
  }

  handleSubmitForPasswordReset(BuildContext context) {
    final resetForm = AuthViewModel.resetFormKey.currentState;
    isLoadingReset = true;

    if (resetForm.validate()) {
      print('validated');
      Future.delayed(Duration(seconds: 2), () {
        isLoadingReset = false;

        notifyListeners();
      });
    } else {
      print('Not validated');
      Future.delayed(Duration(seconds: 3), () {
        isLoadingReset = false;
        notifyListeners();
      });
    }
    notifyListeners();
  }

  handleSubmit(BuildContext context) async {
    final loginForm = AuthViewModel.loginFormKey.currentState;
    isLoading = true;
    buttonState = ButtonState.Loading;
    notifyListeners();

    if (loginForm.validate()) {
      try {
        isLoading = true;
        buttonState = ButtonState.Loading;

        notifyListeners();

        await loginApi.loginUser(context,
            email: email.text, password: passwordController.text);
        alertMessage = 'Welcome back,\n${loginApi.users.fullName}!!';
        isLoading = false;
        buttonState = ButtonState.Initial;
        notifyListeners();
        await Future.delayed(Duration(seconds: 2));
        alertMessage = '';
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (ctx) => HomeView()));
        notifyListeners();
      } catch (e) {
        alertMessage =
            'Request Failed, Try again!!\n[${e.message.toUpperCase()}]';
        isLoading = false;
        buttonState = ButtonState.Initial;

        notifyListeners();
        print(e);
      }
    } else {
      Future.delayed(Duration(seconds: 1), () {
        print('Not validated');
        isLoading = false;
        buttonState = ButtonState.Initial;

        notifyListeners();
      });
    }
    notifyListeners();
  }

  @override
  void clearFields() {
    email.clear();
    passwordController.clear();
  }
}
