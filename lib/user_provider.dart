import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  String? userEmail;
  String? userPassword;

  void setUser(String email, String password) {
    userEmail = email;
    userPassword = password;
    notifyListeners();
  }
}
