
//TODO: agregar validaciones en el mail y Contraseña
// RegExp


abstract class StringValidator {
  bool isValid(String value);
}

class NonEmptyEmailValidator implements StringValidator {
  @override
  //agregar RegReg
  bool isValid(String value) {

    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);

    if (!value.isNotEmpty || !emailValid){
      return false;
    }
    return true;
  }

}

class NonEmptyPasswordValidator implements StringValidator {
  @override
  bool isValid(String value) {

    if (value.isNotEmpty && value.length > 5){
      return true;
    }
    return false;
  }

}


class EmailAndPasswordValidators {
  final StringValidator emailValidator    = NonEmptyEmailValidator();
  final StringValidator passwordValidator = NonEmptyPasswordValidator();

  final String invalidEmailErrorText = 'El mail no es correcto.';
  final String invalidPasswordErrorText = 'Debe tener 6 o mas digitos';
}