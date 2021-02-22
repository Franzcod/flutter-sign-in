import 'package:flutter/material.dart';
import 'package:flutter_google_sign_in/common_widgets/custom_button.dart';

class SignInButton extends CustomButton{
  SignInButton({
    @required String text,
    Color color,
    //double borderRadius,
    Color textColor,
    VoidCallback onPressed,
}) :    assert(text != null),
        super (
    child: Text(
      text,
      style: TextStyle(color: textColor, fontSize: 15.0),
    ),
    color: color,
    height: 50.0,
    //borderRadius: 8.0,
    onPressed: onPressed,
  );
}