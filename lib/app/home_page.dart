
import 'package:flutter/material.dart';
import 'package:flutter_google_sign_in/common_widgets/show_alert_dialog.dart';
import 'package:flutter_google_sign_in/services/auth.dart';
import 'package:provider/provider.dart';

// TODO poner un alert dialog cuando entra en modo anonimo diciendo que solo puede ver algunas cosas 
// sin poder publicar o postularce a ayudas
 
class HomePage extends StatelessWidget {

  Future<void> _signOut(BuildContext context) async{
    try{
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async{
    final didRequestSignOut = await showAlertDialog(
      context, 
      title: 'CERRAR SESION', 
      content: '¿ESTA SEGURO DE IRSE?',
      onlyOneButton: false,
      cancelText: 'CANCELAR', 
      defaultActionText: 'SALIR',
      image: 'images/gif-leave.gif'
    );
    if (didRequestSignOut == true){
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('La Mano App'),
        actions:<Widget> [
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () => _confirmSignOut(context))
        ],
      ),
    );
  }
}
