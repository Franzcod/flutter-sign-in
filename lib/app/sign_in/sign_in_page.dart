import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_google_sign_in/app/sign_in/sign_in_button.dart';
import 'package:flutter_google_sign_in/app/sign_in/social_sign_in_button.dart';
import 'package:flutter_google_sign_in/services/auth.dart';

class SignInPage extends StatelessWidget {

  const SignInPage({Key key,@required this.auth}) : super(key: key);
  final AuthBase auth;

  Future<void> _signInAnonimusly() async{
    try{
      await auth.signInAnonymously();
    } catch (e) {
      //TODO: mostrar cuadro de dialogo con el error al usuario.
      print(e.toString());
    }
  }

  Future<void> _signInWithGoogle() async{
    try{
      await auth.signInWithGoogle();
    } catch (e) {
      //TODO: mostrar cuadro de dialogo con el error al usuario.
      print(e.toString());
    }
  }



  @override
  Widget build(BuildContext context) {

    Random random = new Random();
    int randomNumber = random.nextInt(16);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/wall${randomNumber}.png'),
              colorFilter: ColorFilter.mode(Colors.black26, BlendMode.darken),
              fit: BoxFit.cover,
          )
        ),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 200.0,),
            Text(
              "Sign In",
              textAlign: TextAlign.end,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 25.0,
                letterSpacing: 3
              ),
            ),
            SizedBox(height: 16.0,),
            SignInButton(
              text: "Con cuenta de Email",
              textColor: Colors.black87,
              color: Colors.greenAccent[200],
              onPressed: _signInWithGoogle,
            ),
            SizedBox(height: 8.0,),
            SocialSignInButton(
              assetName: 'images/facebook-logo.png',
              text: "Con cuenta de Facebook",
              textColor: Colors.white,
              color: Color(0xFF334D92),
              onPressed: (){},
            ),
            SizedBox(height: 8.0,),
            SocialSignInButton(
              assetName: 'images/google-logo.png',
              text: "Con cuenta de Google",
              textColor: Colors.black87,
              color: Colors.white,
              onPressed: _signInWithGoogle,

            ),
            SizedBox(height: 8.0,),
            Text(
              "O",
              style: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.0,),
            SignInButton(
              text: "Anonimo",
              textColor: Colors.white,
              color: Colors.blueGrey,
              onPressed: _signInAnonimusly,
            ),


          ],
        )
    );
  }
}


