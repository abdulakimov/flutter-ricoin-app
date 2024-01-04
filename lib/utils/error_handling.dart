import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_ricoin_app/utils/utils.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 201:
      showSnackBar(context, jsonDecode(response.body)['message']);
      break;
    case 400:
      showSnackBar(context, jsonDecode(response.body)['message']);
      break;
    case 500:
      showSnackBar(context, jsonDecode(response.body)['message']);
      break;
    default:
      showSnackBar(context, jsonDecode(response.body)['message']);
  }
}
