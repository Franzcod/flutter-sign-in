
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_sign_in/app/sign_in/email_sign_in_model.dart';
import 'package:flutter_google_sign_in/app/sign_in/sign_in_button.dart';
import 'package:flutter_google_sign_in/app/sign_in/validators.dart';
import 'package:flutter_google_sign_in/common_widgets/show_exception_alert_dialog.dart';
import 'package:flutter_google_sign_in/services/auth.dart';
import 'package:provider/provider.dart';



class EmailSignInFormStateful extends StatefulWidget  with EmailAndPasswordValidators{

  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInFormStateful> {

  final TextEditingController _emailController    = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocusNode    = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  String get _email    => _emailController.text.trim();
  String get _password => _passwordController.text.trim();

  EmailSignInFormType _formType = EmailSignInFormType.signIn;

  bool _submitted = false;
  bool _isLoading = false;

  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _submit() async {
    // print('submit called');
    setState(() {
      _submitted = true;
      _isLoading = true;
    });
    //
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);

      ////////////////
      // simular retraso de conexion
      //await Future.delayed(Duration(seconds: 5));
      ////////////////

      if (_formType == EmailSignInFormType.signIn){
        await auth.signInWithEmailAndPassword(_email, _password);
      } else {
        await auth.createUserWithEmailAndPassword(_email, _password);
      }
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      
      showExceptionAlertDialog(
        context,
        title: 'ERROR AL INICIAR SESION',
        exception: e,
      );
      
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _emailEditingComplete() {
    final newFocus = widget.emailValidator.isValid(_email)
      ? _passwordFocusNode : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _tooggleFormType() {
    setState(() {
      _submitted = false;
      _formType = _formType == EmailSignInFormType.signIn
        ? EmailSignInFormType.register
        : EmailSignInFormType.signIn;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren() {

    final primaryText = _formType == EmailSignInFormType.signIn 
      ? 'ENTRAR' 
      : 'CREAR CUENTA';

    final secondaryText = _formType == EmailSignInFormType.signIn 
      ? '¿No tienes cuenta? Registrate!' 
      : '¿Ya tienes cuenta? Ingresa!';

    bool submitEnabled = widget.emailValidator.isValid(_email) 
                          && widget.passwordValidator.isValid(_password)
                          && !_isLoading;

    return [
      _buildEmailTextField(),
      SizedBox(height: 10.0),
      _buildPasswordTextField(),
      SizedBox(height:20.0),

      !_isLoading 
        ? SignInButton(
          text: primaryText,
          color: Colors.lightGreenAccent,
          textColor: Colors.black,
          onPressed: submitEnabled ? _submit : null,
          ) 
        : Center(child: Container(width: 50,height: 50,child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color> (Colors.lightGreen )))),

      SizedBox(height: 10.0),
      SignInButton(
        text: secondaryText,
        color: Colors.blueGrey,
        textColor: Colors.white,
        onPressed: !_isLoading ? _tooggleFormType : null,
      )
    ];
  }

  TextField _buildPasswordTextField() {

    bool showErrorText = _submitted && !widget.passwordValidator.isValid(_password);

    return TextField(
      onChanged: (password) => _updateState(),
      onEditingComplete: _submit,
      focusNode: _passwordFocusNode,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.visiblePassword,
      controller: _passwordController,
      decoration: InputDecoration(
        labelText: 'Contraseña',
        errorText: showErrorText ?  widget.invalidPasswordErrorText : null,
        enabled: _isLoading == false,
        icon: Icon(Icons.https)
      ),
      obscureText: true,
    );
  }

  TextField _buildEmailTextField() {

    bool showErrorText = _submitted && !widget.emailValidator.isValid(_email);

    return TextField(
      onChanged:  (email) => _updateState(),
      onEditingComplete: _emailEditingComplete,
      focusNode: _emailFocusNode,
      textInputAction: TextInputAction.next,
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      controller: _emailController,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'ejemplo@email.com',
        errorText: showErrorText ?  widget.invalidEmailErrorText : null,
        enabled: _isLoading == false,
        icon: Icon(Icons.email)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildChildren(),
        
      ),
    );
  }

  void _updateState() {
    setState(() {
      
    });
  }
}