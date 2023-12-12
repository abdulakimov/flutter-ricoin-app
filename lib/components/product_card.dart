import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ricoin_app/providers/user_provider.dart';
import 'package:flutter_ricoin_app/services/exchange_services.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatefulWidget {
  final String id;
  final String title;
  final String image;
  final String price;

  const ProductCard({
    super.key,
    required this.title,
    required this.image,
    required this.price,
    required this.id,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final ExchangeServices exchangeServices = ExchangeServices();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Padding(
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
                        color: Colors.black,
                        backgroundColor: Colors.white,
                      ),
                    )
                  : CachedNetworkImage(
                      key: UniqueKey(),
                      imageUrl: widget.image,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(
                          color: Colors.black,
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
                  overflow: TextOverflow.ellipsis
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Narxi: ${widget.price} coin",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
            Align(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                onPressed: () {
                  if (user.bought_products.contains(widget.id)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration(seconds: 1),
                        content: Text("Siz allaqachon sotib oldingiz"),
                      ),
                    );
                    return;
                  } else {
                    exchangeServices.createExchange(context, widget.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration(seconds: 1),
                        content: Text("Savatga qo'shildi"),
                      ),
                    );
                  }
                },
                child: const Text(
                  "Sotib olish",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
