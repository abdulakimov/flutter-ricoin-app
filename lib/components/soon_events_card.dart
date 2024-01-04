import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ricoin_app/screens/event_details_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class SoonEventCard extends StatefulWidget {
  final String id;
  final String name;
  final String coins;
  final String date;
  final String location;
  final List<dynamic> participants;

  const SoonEventCard({
    super.key,
    required this.name,
    required this.coins,
    required this.date,
    required this.location,
    required this.id,
    required this.participants,
  });

  @override
  State<SoonEventCard> createState() => _SoonEventCardState();
}

class _SoonEventCardState extends State<SoonEventCard> {
  @override
  Widget build(BuildContext context) {
    String dateString = widget.date.replaceAll('"', '');

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
                      eventName: widget.name,
                      eventAdress: widget.location,
                      eventTime: widget.date,
                      eventCost: widget.coins,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Container(
          alignment: Alignment.center,
          width: 330,
          decoration: BoxDecoration(
              color: const Color(0xFF4400FF),
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x631500FF),
                  blurRadius: 30,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ]),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: SvgPicture.asset(
                    "assets/icons/bird.svg",
                    height: 140,
                    // ignore: deprecated_member_use
                    color: const Color.fromRGBO(77, 64, 255, 1),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Text(
                      widget.location,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Text(
                      '$day - $monthName, $hoursMinutes da',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sovrin: ${widget.coins} ta ricoin",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                FluentSystemIcons.ic_fluent_person_regular,
                                size: 20,
                                color: Color(0xFF20095F),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                widget.participants.length.toString(),
                                style: const TextStyle(
                                  color: Color(0xFF20095F),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
