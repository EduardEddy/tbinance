import 'package:test_binance/src/domain/datasource/register_datasource.dart';
import 'package:test_binance/src/domain/repositories/register_repository.dart';

class RegisterRepositoryImpl extends RegisterRepository {
  final RegisterDatasource registerDatasource;

  RegisterRepositoryImpl({required this.registerDatasource});

  @override
  Future register({required String email, required String password}) async {
    try {
      return await registerDatasource.register(
          email: email, password: password);
    } catch (e) {
      print('Error register $e');
    }
  }
}
