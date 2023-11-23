import 'package:flutter/material.dart';
import 'package:flutter_ricoin_app/model/user_model.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    name: '',
    surname: '',
    email: '',
    password: '',
    role: '',
    coins: 0,
    avatar: '',
    token: '',
    bought_products: [],
    events: [],
  );

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setUserFromMOdel(User user) {
    _user = user;
    notifyListeners();
  }
}
