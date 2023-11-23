import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ricoin_app/constants/constants.dart';
import 'package:flutter_ricoin_app/model/user_model.dart';
import 'package:flutter_ricoin_app/providers/user_provider.dart';
import 'package:flutter_ricoin_app/utils/error_handling.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ExchangeServices {
  void createExchange(BuildContext context, String productId) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/exchanges/$productId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token':
              // ignore: use_build_context_synchronously
              Provider.of<UserProvider>(context, listen: false).user.token,
        },
      );

      // ignore: use_build_context_synchronously
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            User user = userProvider.user.copyWith(
              bought_products: jsonDecode(response.body)[0]['bought_products'],
            );
            userProvider.setUserFromMOdel(user);
          });
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
