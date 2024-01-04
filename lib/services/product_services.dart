import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ricoin_app/constants/constants.dart';
import 'package:flutter_ricoin_app/model/product_model.dart';
import 'package:flutter_ricoin_app/providers/user_provider.dart';
import 'package:flutter_ricoin_app/utils/error_handling.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ProductServices {
  final List<Product> productList = [];
  Future<List<Product>> getAllProducts(BuildContext context) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products'),
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
              productList.add(
                Product.fromJson(
                  jsonEncode(
                    jsonDecode(response.body)[i],
                  ),
                ),
              );
            }
          });

      return productList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //delete product
  Future<void> deleteProduct(BuildContext context, String productId) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/exchanges/$productId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "x-auth-token":
              // ignore: use_build_context_synchronously
              Provider.of<UserProvider>(context, listen: false).user.token,
        },
      );

      // ignore: use_build_context_synchronously
      httpErrorHandle(response: response, context: context, onSuccess: () {});
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
