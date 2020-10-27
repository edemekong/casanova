import 'package:flutter/material.dart';

abstract class AuthViewModel {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  static GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  static GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  static GlobalKey<FormState> resetFormKey = GlobalKey<FormState>();

  static String validateEmail(String value) {
    if (value.isEmpty) {
      return 'Email can\'t be empty';
    } else if (value.trim().length < 5) {
      return 'Invalid Email';
    } else if (!value.trim().contains('@')) {
      return 'Invalid Email';
    }
    return null;
  }

  static String validatePass(String value) {
    if (value.isEmpty) {
      return 'Passord can\'t be empty';
    } else if (value.trim().length < 8) {
      return 'Password too short';
    }
    return null;
  }

  static String validatePhone(String value) {
    if (value.isEmpty) {
      return 'Phone can\'t be empty';
    } else if (value.trim().length < 10) {
      return 'Invalid Phone number';
    }
    return null;
  }

  static String validateName(String value) {
    if (value.isEmpty) {
      return 'Field can\'t be empty';
    } else if (value.trim().length < 2) {
      return 'Name too short';
    }
    return null;
  }

  void clearFields() {}
}
