import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ricoin_app/constants/constants.dart';
import 'package:flutter_ricoin_app/model/event_model.dart';
import 'package:flutter_ricoin_app/providers/user_provider.dart';
import 'package:flutter_ricoin_app/utils/error_handling.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class EventServices {
  final List<Event> eventList = [];
  Future<List<Event>> getEvents(BuildContext context) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/events'),
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
              eventList.add(
                Event.fromJson(
                  jsonEncode(
                    jsonDecode(response.body)[i],
                  ),
                ),
              );
            }
          });

      return eventList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void registerToEvent(BuildContext context, String eventId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register/$eventId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token':
              Provider.of<UserProvider>(context, listen: false).user.token,
        },
      );

      // ignore: use_build_context_synchronously
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            // print(response.body);
          });
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void exitFromEvent(BuildContext context, String eventId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/scan/$eventId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token':
              Provider.of<UserProvider>(context, listen: false).user.token,
        },
      );

      // ignore: use_build_context_synchronously
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            // print(response.body);
          });
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
