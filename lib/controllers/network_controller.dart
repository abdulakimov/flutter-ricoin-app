import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      Get.defaultDialog(
        contentPadding: const EdgeInsets.all(25),
        barrierDismissible: false,
        title: 'Tarmoqqa ulanmagansiz',
        middleText: 'Iltimos tarmoq sozlamalarini tekshiring',
        backgroundColor: Colors.white,
        radius: 15,
        titlePadding: const EdgeInsets.all(30),
        titleStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        middleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
      );
    } else {
      if (Get.isDialogOpen == true) {
        Get.back();
      }
    }
  }
}
