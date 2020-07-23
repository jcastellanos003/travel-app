import 'dart:async';

class FieldValidators {
  final email =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);

    regExp.hasMatch(email)
        ? sink.add(email)
        : sink.addError('El correo es incorrecto');
  });

  final password = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) => {
            password.length >= 4
                ? sink.add(password)
                : sink.addError('La contraseña debe tener minimo 4 caracteres')
          });
}
