import 'package:flutter/material.dart';
import 'package:flutter_google_sign_in/common_widgets/custom_button.dart';

class SocialSignInButton extends CustomButton{
  SocialSignInButton({
    @required String assetName,
    @required String text,
    Color color,
    Color textColor,
    VoidCallback onPressed,
  }) :  assert(assetName != null),
        assert(text != null),
        super (
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Image.asset(assetName),
            Text(
                text,
                style: TextStyle(color: textColor,fontSize: 15.0),
              ),
            Opacity(
             opacity: 0.0,
              child: Image.asset(assetName),
            ),
          ],
        ),
        height: 50.0,
        color: color,
        onPressed: (){},
      );
}