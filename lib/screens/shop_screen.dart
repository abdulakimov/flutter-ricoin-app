import 'dart:convert';

import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ricoin_app/components/product_card.dart';
import 'package:flutter_ricoin_app/providers/user_provider.dart';
import 'package:flutter_ricoin_app/screens/events_screen.dart';
import 'package:flutter_ricoin_app/screens/orders_screeen.dart';
import 'package:flutter_ricoin_app/services/auth_services.dart';
import 'package:flutter_ricoin_app/services/event_services.dart';
import 'package:flutter_ricoin_app/services/exchange_services.dart';
import 'package:flutter_ricoin_app/services/orders_services.dart';
import 'package:flutter_ricoin_app/services/product_services.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  List<dynamic> events = [];
  List<dynamic> products = [];
  List<dynamic> ordersList = [];
  final ProductServices productServices = ProductServices();
  final AuthServices authServices = AuthServices();
  final ExchangeServices exchangeServices = ExchangeServices();
  final OrdersServices ordersServices = OrdersServices();
  final EventServices eventServices = EventServices();

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
    fetchAllEvents();
    fetchAllOrders();
    authServices.getUserData(context);
  }

  fetchAllOrders() async {
    final orders = await ordersServices.getOrders(context);
    if (mounted) {
      setState(() {
        ordersList = orders;
      });
    }
  }

  fetchAllEvents() async {
    await eventServices.getEvents(context);
    if (mounted) {
      setState(() {
        events = eventServices.eventList;
      });
    }
  }

  fetchAllProducts() async {
    await productServices.getAllProducts(context);
    if (mounted) {
      setState(() {
        products = productServices.productList;
      });
    }
  }

// //dispose fetchAllProducts
//   @override
//   void dispose() {
//     super.dispose();
//     fetchAllProducts();
//     fetchAllEvents();
//   }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    var size = MediaQuery.of(context).size;

    if (products.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(
          color: Color(0xFF20095F),
          backgroundColor: Colors.white,
        ),
      );
    }
    return SafeArea(
      child: LiquidPullToRefresh(
        springAnimationDurationInMilliseconds: 200,
        color: Colors.grey.shade100,
        backgroundColor: const Color(0xFF20095F),
        showChildOpacityTransition: false,
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
          fetchAllProducts();
          products.clear();

          // ignore: use_build_context_synchronously
          authServices.getUserData(context);
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(13),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                                color: Color(0xFF20095F),
                                FluentSystemIcons.ic_fluent_add_circle_filled,
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => const OrdersScreen(),
                              ),
                            );
                          },
                          child: badges.Badge(
                            badgeStyle: const badges.BadgeStyle(
                              badgeColor: Color(0xFF20095F),
                            ),
                            badgeContent: Text(
                              ordersList.length.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            child: const Icon(
                              Icons.shopping_cart_outlined,
                              color: Color(0xFF20095F),
                            ),
                          ))
                    ],
                  ),
                ),
                GridView(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: size.width / (size.height / 1.2),
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 6,
                  ),
                  children: List.generate(
                    products.length,
                    (index) => ProductCard(
                      id: jsonEncode(products[index].id).replaceAll('"', ''),
                      description: jsonEncode(products[index].description)
                          .replaceAll('"', ''),
                      title:
                          jsonEncode(products[index].name).replaceAll('"', ''),
                      image:
                          jsonEncode(products[index].image).replaceAll('"', ''),
                      price:
                          jsonEncode(products[index].price).replaceAll('"', ''),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
