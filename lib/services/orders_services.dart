import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ricoin_app/constants/constants.dart';
import 'package:flutter_ricoin_app/model/orders_model.dart';
import 'package:flutter_ricoin_app/providers/user_provider.dart';
import 'package:flutter_ricoin_app/utils/error_handling.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class OrdersServices {
  Future<List<Orders>> getOrders(BuildContext context) async {
    try {
      final token =
          Provider.of<UserProvider>(context, listen: false).user.token;
      final response = await http.get(
        Uri.parse('$baseUrl/exchanges/user'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
      );

      List<Orders> orders = [];
      // ignore: use_build_context_synchronously
      httpErrorHandle(
        context: context,
        response: response,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(response.body).length; i++) {
            orders.add(
              Orders.fromJson(
                jsonEncode(
                  jsonDecode(response.body)[i],
                ),
              ),
            );
          }
        },
      );

      return orders;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //create order
  Future<void> createOrder(
      BuildContext context, String productId, int amount) async {
    try {
      final token =
          Provider.of<UserProvider>(context, listen: false).user.token;
      final response = await http.post(
        Uri.parse('$baseUrl/exchanges/$productId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
        body: jsonEncode(
          <String, dynamic>{
            'product_id': productId,
            'amount': amount,
          },
        ),
      );

      if (response.body.isNotEmpty) {
        // ignore: use_build_context_synchronously
        httpErrorHandle(
          context: context,
          response: response,
          onSuccess: () {},
        );
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //delete order
  Future<void> deleteOrder(BuildContext context, String orderId) async {
    try {
      final token =
          Provider.of<UserProvider>(context, listen: false).user.token;
      final response = await http.delete(
        Uri.parse('$baseUrl/exchanges/$orderId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
      );

      if (response.body.isNotEmpty) {
        // ignore: use_build_context_synchronously
        httpErrorHandle(
          context: context,
          response: response,
          onSuccess: () {},
        );
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
