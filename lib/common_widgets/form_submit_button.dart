


//////////////////////////////
///no se esta usadon!!!!!!!!!
/////////////////////////////

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_sign_in/common_widgets/custom_button.dart';

class FormSubmitButton extends CustomButton {
  FormSubmitButton({
    @required String text,
    VoidCallback onPressed,
  }) : super(
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 20.0),  
      ),
      height: 44.0,
      color: Colors.lightGreen,
      borderRadius: 4.0,
      onPressed: onPressed,
  );
}