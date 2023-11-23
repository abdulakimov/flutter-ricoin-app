import 'package:flutter/material.dart';
import 'package:flutter_ricoin_app/screens/qr_scanner_screen.dart';
import 'package:flutter_ricoin_app/services/event_services.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class EventDetailsScreen extends StatefulWidget {
  final String eventId;
  final String eventName;
  final String eventAdress;
  final String eventTime;
  final String eventCost;
  const EventDetailsScreen({
    super.key,
    required this.eventName,
    required this.eventAdress,
    required this.eventTime,
    required this.eventCost,
    required this.eventId,
  });

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<UserProvider>(context).user;

    final EventServices eventServices = EventServices();
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

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Tadbir haqida"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tadbir nomi: ${widget.eventName}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 18),
            Text(
              "Tadbir manzili: ${widget.eventAdress}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 18),
            Text(
              "Tadbir vaqti: $day - $monthName, $hoursMinutes da",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 18),
            Text(
              "Tadbir sovrini: ${widget.eventCost} ta coin",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: () async {
          final qrResult = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const QrScannerScreen()),
          );

          if (qrResult.contains("enter")) {
            if (qrResult.replaceAll('enter-', '') != widget.eventId) {
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  duration: Duration(seconds: 5),
                  content: Text("Bu boshqa tadbir kodi!"),
                ),
              );
            } else {
              // ignore: use_build_context_synchronously
              eventServices.registerToEvent(context, widget.eventId);
            }
          }

          if (qrResult.contains("exit")) {
            if (qrResult.replaceAll('exit-', '') != widget.eventId) {
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  duration: Duration(seconds: 3),
                  content: Text("Bu boshqa tadbir kodi!"),
                ),
              );
            } else {
              // ignore: use_build_context_synchronously
              eventServices.exitFromEvent(context, widget.eventId);
            }
          }
        },
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.qr_code_2_sharp,
          color: Colors.black,
        ),
      ),
    );
  }
}
