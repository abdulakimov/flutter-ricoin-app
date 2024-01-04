import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ricoin_app/screens/event_details_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class EventCard extends StatefulWidget {
  final String id;
  final String eventName;
  final String eventAdress;
  final String eventTime;
  final String eventCost;
  final List<dynamic> participants;
  const EventCard({
    super.key,
    required this.eventName,
    required this.eventAdress,
    required this.eventTime,
    required this.eventCost,
    required this.id,
    required this.participants,
  });

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    String dateString = widget.eventTime.replaceAll('"', '');

    DateTime dateTime = DateTime.parse(dateString);

    String monthName = DateFormat('MMMM').format(dateTime);
    String day = DateFormat('d').format(dateTime);

    if (monthName == "January") monthName = "yanvar";
    if (monthName == "February") monthName = "fevral";
    if (monthName == "March") monthName = "mart";
    if (monthName == "April") monthName = "aprel";
    if (monthName == "May") monthName = "may";
    if (monthName == "June") monthName = "iyun";
    if (monthName == "July") monthName = "iyul";
    if (monthName == "August") monthName = "avgust";
    if (monthName == "September") monthName = "sentabr";
    if (monthName == "October") monthName = "oktabr";
    if (monthName == "November") monthName = "noyabr";
    if (monthName == "December") monthName = "dekabr";

    String hoursMinutes = DateFormat('HH:mm').format(dateTime);

    return ZoomTapAnimation(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => EventDetailsScreen(
              eventId: widget.id,
              eventName: widget.eventName,
              eventAdress: widget.eventAdress,
              eventTime: widget.eventTime,
              eventCost: widget.eventCost,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 20),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: Container(
            padding: const EdgeInsets.all(20),
            // width: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: SvgPicture.asset(
                    "assets/icons/flower.svg",
                    width: 80,
                    // ignore: deprecated_member_use
                    color: const Color(0xFFF0F0F0),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.eventName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.eventAdress,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '$day - $monthName, $hoursMinutes da',
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          'Sovrin: ${widget.eventCost} ta ricoin',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: const Color(0xFF20095F),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                FluentSystemIcons.ic_fluent_person_regular,
                                size: 20,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                widget.participants.length.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
