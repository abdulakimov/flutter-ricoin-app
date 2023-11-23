import 'dart:convert';

import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ricoin_app/components/event_card.dart';
import 'package:flutter_ricoin_app/components/rating_card.dart';
import 'package:flutter_ricoin_app/components/soon_events_card.dart';
import 'package:flutter_ricoin_app/services/auth_services.dart';
import 'package:flutter_ricoin_app/providers/user_provider.dart';
import 'package:flutter_ricoin_app/screens/events_screen.dart';
import 'package:flutter_ricoin_app/services/event_services.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> events = [];
  List<dynamic> users = [];
  final EventServices eventServices = EventServices();
  final AuthServices authServices = AuthServices();

  @override
  void initState() {
    super.initState();
    fetchAllEvents();
    fetchAllUsers();
  }

  fetchAllEvents() async {
    await eventServices.getEvents(context);
    setState(() {
      events = eventServices.eventList;
    });
  }

  fetchAllUsers() async {
    await authServices.getAllUsers(context);
    setState(() {
      users = authServices.usersList;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    AuthServices authServices = AuthServices();

    if (events.isEmpty || users.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.black,
          backgroundColor: Colors.white,
        ),
      );
    }

    return SafeArea(
      child: LiquidPullToRefresh(
        springAnimationDurationInMilliseconds: 200,
        color: Colors.grey.shade100,
        backgroundColor: Colors.black,
        showChildOpacityTransition: false,
        onRefresh: () async {
          events.clear();
          users.clear();
          fetchAllEvents();
          fetchAllUsers();
          await Future.delayed(const Duration(seconds: 1));
          // ignore: use_build_context_synchronously
          authServices.getUserData(context);
          // ignore: use_build_context_synchronously
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        "${user.surname} ${user.name}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EventScreen(
                              events: events,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        width: 80,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              user.coins.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const Icon(
                              FluentSystemIcons.ic_fluent_add_circle_filled,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Align(
                child: SoonEventCard(
                  id: jsonEncode(events[0].id).replaceAll('"', ''),
                  name: jsonEncode(events[0].name).replaceAll('"', ''),
                  location: jsonEncode(events[0].location).replaceAll('"', ''),
                  date: jsonEncode(events[0].date).replaceAll('"', ''),
                  coins: jsonEncode(events[0].coins).replaceAll('"', ''),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Bu haftadagi tadbirlar",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        children: [
                          for (var i = 0; i < events.length; i++)
                            EventCard(
                              eventName: jsonEncode(events[i].name)
                                  .replaceAll('"', ''),
                              eventAdress: jsonEncode(events[i].location)
                                  .replaceAll('"', ''),
                              eventTime: jsonEncode(events[i].date)
                                  .replaceAll('"', ''),
                              eventCost: jsonEncode(events[i].coins)
                                  .replaceAll('"', ''),
                              id: jsonEncode(events[i].id).replaceAll('"', ''),
                            ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Reyting",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Align(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Column(
                          children: [
                            for (var i = 0; i < 3; i++)
                              RatingCard(
                                placerName:
                                    "${jsonEncode(users[i].surname).replaceAll('"', '')} ${jsonEncode(users[i].name).replaceAll('"', '')}",
                                iconAdress: 'assets/images/$i-medal.png',
                                coinCount: jsonEncode(users[i].coins)
                                    .replaceAll('"', ''),
                              ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
