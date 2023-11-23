import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ricoin_app/components/events_card.dart';

class EventScreen extends StatefulWidget {
  final List events;
  const EventScreen({super.key, required this.events});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  @override
  Widget build(BuildContext context) {
    if (widget.events.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.black,
          backgroundColor: Colors.white,
        ),
      );
    }
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Barcha tadbirlar"),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Align(
            child: Column(
              children: [
                for (var i = 0; i < widget.events.length; i++)
                  EventsCard(
                      id: jsonEncode(widget.events[i].id).replaceAll('"', ''),
                      name:
                          jsonEncode(widget.events[i].name).replaceAll('"', ''),
                      coins: jsonEncode(widget.events[i].coins)
                          .replaceAll('"', ''),
                      date:
                          jsonEncode(widget.events[i].date).replaceAll('"', ''),
                      location: jsonEncode(widget.events[i].location)
                          .replaceAll('"', '')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
