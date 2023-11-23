import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ricoin_app/providers/user_provider.dart';
import 'package:flutter_ricoin_app/screens/information_screen.dart';
import 'package:flutter_ricoin_app/screens/orders_screeen.dart';
import 'package:flutter_ricoin_app/services/auth_services.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    AuthServices authServices = AuthServices();
    final user = Provider.of<UserProvider>(context).user;
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Align(
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  color: Colors.grey.shade200,
                ),
                child: const Icon(
                  FluentSystemIcons.ic_fluent_person_filled,
                  color: Colors.grey,
                  size: 100,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "${user.surname} ${user.name}",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                InkWell(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const OrdersScreen(),
                      ),
                    );
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(FluentSystemIcons.ic_fluent_list_regular),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Buyurtmalarim",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Icon(FluentSystemIcons.ic_fluent_chevron_right_regular)
                    ],
                  ),
                ),
                const Divider(color: Colors.white),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const InfoScreen(),
                      ),
                    );
                  },
                  child: const Row(
                    children: [
                      Row(
                        children: [
                          Icon(FluentSystemIcons.ic_fluent_notepad_regular),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Dastur haqida",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Spacer(),
                      Icon(FluentSystemIcons.ic_fluent_chevron_right_regular)
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: GestureDetector(
                  onTap: () {
                    authServices.signOut(context);
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey.shade200,
                    ),
                    child: const Icon(
                      FluentSystemIcons.ic_fluent_sign_out_regular,
                      color: Colors.grey,
                      size: 30,
                    ),
                  ),
                ),
              ),
              const Text("Chiqish", style: TextStyle(color: Colors.grey)),
            ],
          ),
          const Text("v1.0.0", style: TextStyle(color: Colors.grey)),
          const Text("Parvoz liderlar jamosi tomonidan ishlab chiqildi",
              style: TextStyle(color: Colors.grey)),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
