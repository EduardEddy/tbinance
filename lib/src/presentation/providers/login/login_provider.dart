import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test_binance/src/infratructure/datasource/login_datasource_impl.dart';
import 'package:test_binance/src/infratructure/repositories/login_repository_impl.dart';

class LoginProvider extends ChangeNotifier {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final loginRepository =
      LoginRepositoryImpl(loginDatasource: LoginDatasourceImpl());

  Future submit() async {
    if (_formKey.currentState!.validate()) {
      final resp = await loginRepository.login(
        email: _email.text,
        password: _password.text,
      );

      if (resp == null) {
        return {'navigate': false, 'showMessage': true};
      }
      return {'navigate': true, 'showMessage': false};
    }

    return {'navigate': false, 'showMessage': false};
  }

  //Gether
  GlobalKey get formKey => _formKey;
  TextEditingController get email => _email;
  TextEditingController get password => _password;
}
