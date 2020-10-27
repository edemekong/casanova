import 'package:flutter/material.dart';
import '../../../../../ui/commons/sizes.dart';
import '../../../../../view_models/theme_view_model/theme_model.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function onPressed;

  final Function onTapForgotPassword;
  const AlreadyHaveAnAccountCheck({
    Key key,
    this.login = true,
    this.onPressed,
    this.onTapForgotPassword,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        login
            ? Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: InkWell(
                    onTap: onTapForgotPassword,
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ))
            : Container(),
        sizedBoxHeight16,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              login ? "Don’t have an Account ? " : "Already have an Account ? ",
              style: TextStyle(color: primaryColor, fontSize: 15),
            ),
            GestureDetector(
              onTap: onPressed,
              child: Text(
                login ? "Create Account" : "Login",
                style: TextStyle(
                  color: Colors.blue[400],
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
