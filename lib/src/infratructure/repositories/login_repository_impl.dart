import 'package:test_binance/src/domain/datasource/login_datasource.dart';
import 'package:test_binance/src/domain/repositories/login_repository.dart';

class LoginRepositoryImpl extends LoginRepository {
  final LoginDatasource loginDatasource;

  LoginRepositoryImpl({required this.loginDatasource});

  @override
  Future login({required String email, required String password}) async {
    try {
      final login = await loginDatasource.login(
        email: email,
        password: password,
      );
      return login;
    } catch (e) {
      print('Error login $e');
      return null;
    }
  }
}
