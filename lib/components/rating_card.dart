import 'package:flutter/material.dart';

class RatingCard extends StatefulWidget {
  final String placerName;
  final String iconAdress;
  final String coinCount;

  const RatingCard({
    super.key,
    required this.placerName,
    required this.iconAdress,
    required this.coinCount,
  });

  @override
  State<RatingCard> createState() => _RatingCardState();
}

class _RatingCardState extends State<RatingCard> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Container(
        padding: const EdgeInsets.all(10),
        width: size.width,
        height: 80,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.iconAdress.contains("cloudinary")
                      ? widget.iconAdress
                      : "https://res.cloudinary.com/xurshidbey/image/upload/v1703793751/avatar/g8hk9ea0eiuw2ayxipsd.png"),
                  fit: BoxFit.contain,
                ),
                color: Colors.grey.shade200,
                borderRadius: const BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  widget.placerName,
                  style: const TextStyle(
                      fontSize: 16, overflow: TextOverflow.ellipsis),
                ),
              ),
            ),
            Text(widget.coinCount,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
      ),
    );
  }
}
