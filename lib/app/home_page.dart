import 'package:flutter/material.dart';
import 'package:flutter_google_sign_in/services/auth.dart';


class HomePage extends StatelessWidget {

  const HomePage({Key key,@required this.auth,}) : super(key: key);
  final AuthBase auth;


  Future<void> _signOut() async{
    try{
      await auth.signOut();
    } catch (e) {
      //TODO: mostrar cuadro de dialogo con el error al usuario.
      print(e.toString());
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        actions:<Widget> [
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: _signOut)
        ],
      ),
    );
  }
}
