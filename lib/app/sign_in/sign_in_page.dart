import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_sign_in/app/sign_in/email_sign_in_page.dart';
import 'package:flutter_google_sign_in/app/sign_in/sign_in_Manager.dart';
import 'package:flutter_google_sign_in/app/sign_in/sign_in_button.dart';
import 'package:flutter_google_sign_in/app/sign_in/social_sign_in_button.dart';
import 'package:flutter_google_sign_in/common_widgets/show_alert_dialog.dart';
import 'package:flutter_google_sign_in/common_widgets/show_exception_alert_dialog.dart';
import 'package:flutter_google_sign_in/services/auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({
    Key key,
    @required this.manager,
    @required this.isLoading,
  }) : super(key: key);
  final SignInManager manager;
  final bool isLoading;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (_, isLoading, __) => Provider<SignInManager>(
          create: (_) => SignInManager(auth: auth, isLoading: isLoading),
          child: Consumer<SignInManager>(
            builder: (_, manager, __) =>
                SignInPage(manager: manager, isLoading: isLoading.value),
          ),
        ),
      ),
    );
  }

  
  void _showSignInError(BuildContext context, Exception exception){
    if (exception is FirebaseException && exception.code == 'ERROR_ABORTED_BY_USER'){
      return;
    }
    showExceptionAlertDialog(
      context,
      title: 'ERROR DE INICIO DE SESION',
      exception: exception
    );
  }

  Future<void> _signInAnonimusly(BuildContext context) async{
    try{
      await manager.signInAnonymously();
    } on Exception catch (e) {
      _showSignInError(context, e);
      print(e.toString());
    } 
  }

  Future<void> _signInWithGoogle(BuildContext context) async{
    try{
      await manager.signInWithGoogle();
    } on Exception catch (e) {
      _showSignInError(context, e);
      print(e.toString());
    } 
  }

  Future<void> _signInWithFacebook(BuildContext context) async{
    try{
      await manager.signInWithFacebook();
    } on Exception catch (e) {
      _showSignInError(context, e);
      print(e.toString());
    } 
  }

  void _signInWithEmail(BuildContext context){
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => EmailSignInPage(),
      )
    );
  }

  @override
  Widget build(BuildContext context) {

    Random random = new Random();
    int randomNumber = random.nextInt(16);
    final foto = 'images/wall11.png';

    return Scaffold(
      body: Container(
        color: Colors.grey[100],
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //       image: AssetImage(foto),
        //       colorFilter: ColorFilter.mode(Colors.black26, BlendMode.darken),
        //       fit: BoxFit.cover,
        //   )
        // ),
        ////////////////////////////////////////////
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     begin: Alignment.bottomLeft,
        //     end:
        //         Alignment(0.8, 0.0), // 10% of the width, so there are ten blinds.
        //     colors: [
        //       Colors.white10,
        //       Colors.lightBlueAccent,
        //       Colors.lightGreen
        //     ], // red to yellow
        //     tileMode: TileMode.mirror, // repeats the gradient over the canvas
        //   ),
        // ),
        child:  _buildContent(context),
  
        ),
      );
  }

  Widget _buildContent(BuildContext context) {

    Random random2 = new Random();
    final colores = [ Colors.amber, Colors.black, Colors.pinkAccent, Colors.redAccent, Colors.greenAccent, Colors.lightGreen, Colors.blueAccent, Colors.lightBlue, Colors.yellowAccent];
    int randomColor = random2.nextInt(colores.length);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "LA MANO",
                textAlign: TextAlign.start,
                style: GoogleFonts.lato(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color:  Theme.of(context).primaryColor,
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(2.0, 2.0),
                      blurRadius: 1.0,
                      color: Colors.black12,
                    ),
                    // Shadow(
                    //   offset: Offset(3.0, 3.0),
                    //   blurRadius: 1.0,
                    //   color: colores[randomColor],
                    // ),
                  ]
                )
              ),
            ),
            // SizedBox(
            //   width: 100,
            //   child: Image.asset('images/huoo.png'),
              
            // ),
            Container(
              width: double.infinity,
              height: 130,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/huoo.png'),
                  fit: BoxFit.fill
                ),
              )
            ),
            SizedBox(height: 16,),
            
          ]   
        ),
        
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
        
        child: Column(
          
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Iniciar",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                      fontSize: 25.0,
                      letterSpacing: 3
                    ),
                  ),
                  _buildHeader()

                ]
              ),

              SizedBox(height: 16.0,),
              SignInButton(
                text: "Con cuenta de Email",
                textColor: Colors.black87,
                //color: Color.fromRGBO(198, 255, 75, 100),
                //color: Color.fromRGBO(22, 245, 147, 96),
                color: Theme.of(context).primaryColor,
                onPressed: isLoading ? null : () => _signInWithEmail(context),
              ),
              SizedBox(height: 8.0,),
              SocialSignInButton(
                assetName: 'images/facebook-logo.png',
                text: "Con cuenta de Facebook",
                textColor: Colors.white,
                color: Color(0xFF334D92),
                onPressed: isLoading ? null :  () => _signInWithFacebook(context),
              ),
              SizedBox(height: 8.0,),
              SocialSignInButton(
                assetName: 'images/google-logo.png',
                text: "Con cuenta de Google",
                textColor: Colors.black87,
                color: Colors.white,
                onPressed: isLoading ? null :  () => _signInWithGoogle(context),

              ),
              SizedBox(height: 8.0,),
              Text(
                "O",
                style: TextStyle(fontSize: 14.0, color: Colors.black87,fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.0,),
              SignInButton(
                text: "Anonimo",
                textColor: Colors.white,
                color: Colors.blueGrey,
                onPressed: isLoading ? null :  () => _confirmSignInAnonimus(context),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: GestureDetector(
                  onTap: () {
                    const url = 'https://fpalacios.com.ar';
                    _launchURL(url);
                  },
                  child: Text(
                    "Franzcod develops®",
                    style: TextStyle(fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          )
        ),
      ],
    );
  }

  Widget _buildHeader() {
    if (isLoading ) {
      return  SizedBox(width: 50,child: CircularProgressIndicator(strokeWidth: 10.0, ));
    } else {
      return Container();
      //return Opacity(opacity: 0.0,child: SizedBox(width: 50,child: CircularProgressIndicator()));
    }
    
  }
  // Muestra web view al apretar
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
 }
  // Confirmar modo aninimo
 Future<void> _confirmSignInAnonimus(BuildContext context) async{
    final didRequestSignIn = await showAlertDialog(
      context, 
      title: 'INICIAR COMO ANONIMO', 
      content: 'En modo anonimo solo podra chusmear \nel funcionamiento general.',
      onlyOneButton: false,
      cancelText: 'CANCELAR', 
      defaultActionText: 'OK',
      image: 'images/gif-anon.gif'
    );
    if (didRequestSignIn == true){
      _signInAnonimusly(context);
    }
  }

}








          