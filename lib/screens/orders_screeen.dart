import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ricoin_app/services/orders_services.dart';
import 'package:flutter_ricoin_app/services/product_services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<dynamic> productsList = [];
  List<dynamic> ordersList = [];
  final ProductServices productServices = ProductServices();
  final OrdersServices ordersServices = OrdersServices();

  @override
  void initState() {
    super.initState();
    fetchAllOrders();
    fetchAllProducts();
  }

  //fetch all orders
  fetchAllOrders() async {
    final orders = await ordersServices.getOrders(context);
    setState(() {
      ordersList = orders;
    });
  }

  fetchAllProducts() async {
    await productServices.getAllProducts(context);
    setState(() {
      productsList = productServices.productList;
    });
  }

  //delete order
  deleteOrder(BuildContext context, String orderId) async {
    await ordersServices.deleteOrder(context, orderId);
    fetchAllOrders();
  }

  @override
  Widget build(BuildContext context) {
    //sort products by orders
    List<dynamic> sortedProducts = [];
    for (int i = 0; i < ordersList.length; i++) {
      for (int j = 0; j < productsList.length; j++) {
        if (ordersList[i].product_id == productsList[j].id) {
          sortedProducts.add(productsList[j]);
        }
      }
    }

    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text("Buyurtmalar"),
        ),
        body: productsList.isEmpty
            ? const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF20095F),
                  backgroundColor: Colors.white,
                ),
              )
            : sortedProducts.isEmpty
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
                            child: Slidable(
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {
                                      deleteOrder(
                                          context, ordersList[index].id);
                                    },
                                    foregroundColor: Colors.red,
                                    backgroundColor: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(10),
                                    autoClose: true,
                                    icon: FluentSystemIcons
                                        .ic_fluent_delete_regular,
                                  ),
                                ],
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
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          sortedProducts[index].name,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          sortedProducts[index]
                                                  .description
                                                  .isEmpty
                                              ? "Malumot berilmagan"
                                              : sortedProducts[index]
                                                  .description
                                                  .toString(),
                                          style: const TextStyle(
                                            fontSize: 12,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Narxi: ${sortedProducts[index].price * ordersList[index].amount} ricoin",
                                          style: const TextStyle(
                                            fontSize: 15,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Buyurtma soni: ${ordersList[index].amount}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ));
  }
}
