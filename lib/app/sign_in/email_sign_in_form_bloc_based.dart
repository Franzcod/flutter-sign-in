
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_sign_in/app/sign_in/email_sign_in_bloc.dart';
import 'package:flutter_google_sign_in/app/sign_in/email_sign_in_model.dart';
import 'package:flutter_google_sign_in/app/sign_in/sign_in_button.dart';
import 'package:flutter_google_sign_in/common_widgets/show_exception_alert_dialog.dart';
import 'package:flutter_google_sign_in/services/auth.dart';
import 'package:provider/provider.dart';



class EmailSignInFormBlocBased extends StatefulWidget {

  EmailSignInFormBlocBased({@required this.bloc});
  final EmailSignInBloc bloc;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Provider<EmailSignInBloc>(
      create: (_) => EmailSignInBloc(auth: auth),
      child: Consumer<EmailSignInBloc>(
        builder: (_, bloc, __) => EmailSignInFormBlocBased(bloc:  bloc,),
      ),
      dispose: (_, bloc) => bloc.dispose(),
    );
  }

  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInFormBlocBased> {

  final TextEditingController _emailController    = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocusNode    = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  

  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _submit() async {
    
    try {
      await widget.bloc.submit();
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      
      showExceptionAlertDialog(
        context,
        title: 'ERROR AL INICIAR SESION',
        exception: e,
      );
    } 
  }

  void _emailEditingComplete(EmailSignInModel model) {
    final newFocus = model.emailValidator.isValid(model.email)
      ? _passwordFocusNode : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _tooggleFormType() {
    widget.bloc.toggleFormType();
    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren(EmailSignInModel model) {

    

    return [
      _buildEmailTextField(model),
      SizedBox(height: 10.0),
      _buildPasswordTextField(model),
      SizedBox(height:20.0),

      !model.isLoading 
        ? SignInButton(
          text: model.primaryButtonText,
          color: Colors.lightGreenAccent,
          textColor: Colors.black,
          onPressed: model.canSubmit ? _submit : null,
          ) 
        : Center(child: Container(width: 50,height: 50,child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color> (Colors.lightGreen )))),

      SizedBox(height: 10.0),
      SignInButton(
        text: model.secondaryButtonText,
        color: Colors.blueGrey,
        textColor: Colors.white,
        onPressed: !model.isLoading ?  _tooggleFormType : null,
      )
    ];
  }

  TextField _buildPasswordTextField(model) {

    return TextField(
      onChanged:  widget.bloc.updatePassword,
      onEditingComplete: _submit,
      focusNode: _passwordFocusNode,
      textInputAction: TextInputAction.none,
      keyboardType: TextInputType.visiblePassword,
      controller: _passwordController,
      decoration: InputDecoration(
        labelText: 'Contraseña',
        errorText: model.passwordErrorText,
        enabled: model.isLoading == false,
        icon: Icon(Icons.https)
      ),
      obscureText: true,
    );
  }

  TextField _buildEmailTextField(model) {

    return TextField(
      onChanged:   widget.bloc.updateEmail,
      onEditingComplete: () => _emailEditingComplete(model),
      focusNode: _emailFocusNode,
      textInputAction: TextInputAction.next,
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      controller: _emailController,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'ejemplo@email.com',
        errorText: model.emailErrorText,
        enabled: model.isLoading == false,
        icon: Icon(Icons.email)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<EmailSignInModel>(
      stream: widget.bloc.modelStream,
      initialData: EmailSignInModel(),
      builder: (context, snapshot) {
        final EmailSignInModel model = snapshot.data;
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: _buildChildren(model),
            
          ),
        );
      }
    );
  }
}