


import 'package:flutter/cupertino.dart';
import 'package:flutter_google_sign_in/app/sign_in/email_sign_in_model.dart';
import 'package:flutter_google_sign_in/app/sign_in/validators.dart';
import 'package:flutter_google_sign_in/services/auth.dart';


class EmailSignInChangeModel with EmailAndPasswordValidators, ChangeNotifier {

  EmailSignInChangeModel({
    @required this.auth,
    this.email = '', 
    this.password = '', 
    this.formType = EmailSignInFormType.signIn, 
    this.isLoading = false, 
    this.submitted = false,
  });
  final AuthBase auth;
  String email;
  String password;
  EmailSignInFormType formType;
  bool isLoading;
  bool submitted;

  Future<void>  submit() async {
    // print('submit called');
    updateWith(submitted: true, isLoading: true);
    //
    try {
      ////////////////
      // simular retraso de conexion
      //await Future.delayed(Duration(seconds: 5));
      ////////////////

      if (formType == EmailSignInFormType.signIn){
        await auth.signInWithEmailAndPassword(email, password);
      } else {
        await auth.createUserWithEmailAndPassword(email, password);
      }
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }

  String get primaryButtonText {
    return formType == EmailSignInFormType.signIn 
      ? 'ENTRAR' 
      : 'CREAR CUENTA';
  }

  String get secondaryButtonText {
    return formType == EmailSignInFormType.signIn 
      ? '¿No tienes cuenta? Registrate!' 
      : '¿Ya tienes cuenta? Ingresa!';
  }

  bool get canSubmit {
    return emailValidator.isValid(email) 
                          && passwordValidator.isValid(password)
                          && !isLoading;
  }

  String get passwordErrorText {
    bool showErrorText = submitted && !passwordValidator.isValid(password);
    return showErrorText ? invalidPasswordErrorText : null;
  }

  String get emailErrorText {
    bool showErrorText = submitted && !emailValidator.isValid(email);
    return showErrorText ? invalidEmailErrorText : null ;
  }

  void toggleFormType() {
    final formType = this.formType == EmailSignInFormType.signIn
        ? EmailSignInFormType.register
        : EmailSignInFormType.signIn;

    updateWith(
      email: '',
      password: '',
      formType: formType ,
      isLoading: false,
      submitted: false,

    );
  }

  void updateEmail(String email)  => updateWith(email: email);

  void updatePassword(String password) => updateWith(password: password);

  void updateWith({
    String email,
    String password,
    EmailSignInFormType formType,
    bool isLoading,
    bool submitted,
  }) {
      this.email = email ?? this.email;
      this.password = password ?? this.password;
      this.formType = formType ?? this.formType;
      this.isLoading = isLoading ?? this.isLoading;
      this.submitted = submitted ?? this.submitted;
      notifyListeners();
  }
  
}