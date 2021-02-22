import 'package:flutter/material.dart';
import 'package:flutter_google_sign_in/app/sign_in/email_sign_in_form_bloc_based.dart';
import 'package:flutter_google_sign_in/app/sign_in/email_sign_in_form_change_notifier.dart';

class EmailSignInPage extends StatelessWidget {
  

   @override
  Widget build(BuildContext context) {


    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Iniciar con Email"),
        backgroundColor: Colors.grey[200],
        elevation: 0.0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Image.asset('images/klip.png')
                ),
                SizedBox(height: 10,),
                Card(
                  shadowColor: Colors.lightGreen,
                  elevation: 15.0,
                  child: EmailSignInFormChangeNotifier.create(context),
                ),
              ],
            ),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
}
        
 
}