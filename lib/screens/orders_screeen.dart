import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ricoin_app/providers/user_provider.dart';
import 'package:flutter_ricoin_app/services/auth_services.dart';
import 'package:flutter_ricoin_app/services/product_services.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<dynamic> products = [];
  final ProductServices productServices = ProductServices();
  final AuthServices authServices = AuthServices();

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
    authServices.getUserData(context);
  }

  fetchAllProducts() async {
    await productServices.getAllProducts(context);
    setState(() {
      products = productServices.productList;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    // filter products by bought_products
    final sortedProducts = products.where((product) {
      return user.bought_products.contains(product.id);
    }).toList();

    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text("Buyurtmalar"),
        ),
        body: sortedProducts.isEmpty
            ? const Center(
                child: Text(
                  "Sizda hali buyurtmalar yo'q",
                  style: TextStyle(
                    fontSize: 18,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: List.generate(sortedProducts.length, (index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                        sortedProducts[index].image),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  sortedProducts[index].name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  sortedProducts[index].description.isEmpty
                                      ? "Malumot berilmagan"
                                      : sortedProducts[index]
                                          .description
                                          .toString(),
                                  style: const TextStyle(
                                      fontSize: 12,
                                      overflow: TextOverflow.visible),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "${sortedProducts[index].price.toString()} coin",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "Olib ketilishi kutilmoqda",
                                  style: TextStyle(
                                    fontSize: 14,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ));
  }
}
