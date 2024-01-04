import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ricoin_app/screens/product_details_screen.dart';
import 'package:flutter_ricoin_app/services/exchange_services.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class ProductCard extends StatefulWidget {
  final String id;
  final String title;
  final String image;
  final String price;
  final String description;

  const ProductCard({
    super.key,
    required this.title,
    required this.image,
    required this.price,
    required this.id,
    required this.description,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final ExchangeServices exchangeServices = ExchangeServices();
  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => ProductDetailsScreen(
              id: widget.id,
              title: widget.title,
              image: widget.image,
              price: widget.price,
              description: widget.description,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.shade100,
                ),
                child: widget.image.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF20095F),
                          backgroundColor: Colors.white,
                        ),
                      )
                    : CachedNetworkImage(
                        key: UniqueKey(),
                        imageUrl: widget.image,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF20095F),
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    // fontWeight: FontWeight.bold,
                    fontSize: 14,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Text(
                "Narxi: ${widget.price} ricoin",
                style: const TextStyle(
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
