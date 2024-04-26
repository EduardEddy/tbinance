import 'package:test_binance/src/config/helpers/users_helper.dart';
import 'package:test_binance/src/domain/datasource/login_datasource.dart';

class LoginDatasourceImpl extends LoginDatasource {
  final UserHelper _userHelper = UserHelper();

  @override
  Future login({required String email, required String password}) async {
    final List users = await _userHelper.getUsers();
    try {
      return users.firstWhere((element) =>
          element['email'] == email && element['password'] == password);
    } catch (e) {
      print("error $e");
    }
  }
}
