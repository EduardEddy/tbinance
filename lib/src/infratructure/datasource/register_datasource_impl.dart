import 'package:test_binance/src/config/helpers/users_helper.dart';
import 'package:test_binance/src/domain/datasource/register_datasource.dart';

class RegisterDatasourceImpl extends RegisterDatasource {
  final UserHelper _userHelper = UserHelper();

  @override
  Future register({required String email, required String password}) async {
    return await _userHelper.registerUser(email, password);
  }
}
