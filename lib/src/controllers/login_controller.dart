import 'package:shared_preferences/shared_preferences.dart';
import 'package:utilidades/src/models/user_model.dart';
import 'package:utilidades/src/services/api_service.dart';

class LoginController {
  /*   UserModel _mockUser = UserModel(username: "admin", password: "123456");

  Future<bool> login(String username, String password) async{
    await Future.delayed(Duration(seconds: 2));
    return username == _mockUser.username && password == _mockUser.password;
  } */

  final _ApiService = ApiService();

  Future<bool> login(UserModel user) async {
    final token = await _ApiService.login(user.toJson());

    if (token != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', token);
      return true;
    }

    return false;
  }
}
