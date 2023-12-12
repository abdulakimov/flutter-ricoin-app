import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ricoin_app/model/user_model.dart';
import 'package:flutter_ricoin_app/providers/user_provider.dart';
import 'package:flutter_ricoin_app/screens/main_screen.dart';
import 'package:flutter_ricoin_app/screens/signin_screen.dart';
import 'package:flutter_ricoin_app/utils/error_handling.dart';
import 'package:flutter_ricoin_app/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import base url
import '../constants/constants.dart';

class AuthServices {
  void signUp({
    required BuildContext context,
    required String name,
    required String surname,
    required String email,
    required String password,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        surname: surname,
        email: email,
        password: password,
        role: '',
        coins: 0,
        avatar: '',
        token: '',
        bought_products: [],
        events: [],
      );

      final response = await http.post(
        Uri.parse('$baseUrl/users/sign-up'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SignIn(),
            ),
          );
        },
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString());
    }
  }

  void signIn({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$baseUrl/users/sign-in'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          // ignore: use_build_context_synchronously
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);

          // ignore: use_build_context_synchronously
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const MainScreen()));
        },
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString());
    }
  }

  // get user data
  Future getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('$baseUrl/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );
      var response = jsonDecode(tokenRes.body);
      var id = response['id'];

      if (response['status'] == true) {
        http.Response userRes = await http.get(
          Uri.parse('$baseUrl/users/$id'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );
        // print(userRes.body);

        // ignore: use_build_context_synchronously
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(jsonEncode(jsonDecode(userRes.body)));

        // print(userProvider.user.name);
      }
    } catch (e) {
      // showSnackBar(context, e.toString());
    }
  }

  void signOut(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('x-auth-token', '');
    //set token to empty in provider
    // Provider.of<UserProvider>(context, listen: false).setUser('');
    // ignore: use_build_context_synchronously

    // ignore: use_build_context_synchronously
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignIn(),
      ),
    );
  }

  final List<User> usersList = [];
  Future<List<User>> getAllUsers(BuildContext context) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      // ignore: use_build_context_synchronously
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(response.body).length; i++) {
              usersList.add(
                User.fromJson(
                  jsonEncode(
                    jsonDecode(response.body)[i],
                  ),
                ),
              );
            }
          });

      return usersList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}









// final response = await http.get(
//         Uri.parse('$baseUrl/users'),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//       );

//       // ignore: use_build_context_synchronously
//       httpErrorHandle(
//           response: response,
//           context: context,
//           onSuccess: () {
//             for (int i = 0; i < jsonDecode(response.body).length; i++) {
//               usersList.add(
//                 User.fromJson(
//                   jsonEncode(
//                     jsonDecode(response.body)[i],
//                   ),
//                 ),
//               );
//             }
//           });

//       return usersList;