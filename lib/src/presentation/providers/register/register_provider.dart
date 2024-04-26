import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test_binance/src/infratructure/datasource/register_datasource_impl.dart';
import 'package:test_binance/src/infratructure/repositories/register_repository_impl.dart';

class RegisterProvider extends ChangeNotifier {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  final _registerRepository =
      RegisterRepositoryImpl(registerDatasource: RegisterDatasourceImpl());

  validateConfirmPassword() {
    if (_password.text != _confirmPassword.text) {
      return 'Las contraseñas no son iguales';
    }
    return null;
  }

  Future submit() async {
    if (_formKey.currentState!.validate()) {
      final resp = await _registerRepository.register(
        email: _email.text,
        password: _password.text,
      );
      if (!resp) {
        return {'messageError': true, 'messageSuccess': false};
      }
      return {'messageError': false, 'messageSuccess': true};
    }
    return {'messageError': false, 'messageSuccess': false};
  }

  //Gether
  GlobalKey get formKey => _formKey;
  TextEditingController get email => _email;
  TextEditingController get password => _password;
  TextEditingController get confirmPassword => _confirmPassword;
}
