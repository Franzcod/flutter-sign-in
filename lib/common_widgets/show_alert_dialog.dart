


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

Future<bool> showAlertDialog(
  BuildContext context, {
    @required String title,
    @required String content,
    bool onlyOneButton = true,
    String image = 'images/gif-alert.gif',
    @required String defaultActionText,
    String cancelText = 'Cancel',
  }
) {
    return showDialog(
      context: context,
      builder: (context) => NetworkGiffyDialog(
        image: Image.asset(image, fit: BoxFit.cover),
        title: Text(title, style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        description: Text(content),
        onlyOkButton: onlyOneButton,
        buttonOkText: Text(defaultActionText),
        buttonOkColor: Theme.of(context).primaryColor,
        buttonCancelText: Text(cancelText),
        buttonCancelColor: Colors.red[200],
        onOkButtonPressed: () => Navigator.of(context).pop(true),
        entryAnimation: EntryAnimation.BOTTOM,
        
      )
    );
  }
