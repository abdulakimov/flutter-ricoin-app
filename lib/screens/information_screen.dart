import 'package:accordion/accordion.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF20095F),
        title: const Text("Ma'lumotlar"),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Accordion(
              children: [
                AccordionSection(
                  headerBorderRadius: 5,
                  headerPadding: const EdgeInsets.all(12),
                  headerBackgroundColor: Colors.white,
                  header: const Text(
                    "Dastur qanday ishlaydi?",
                    style: TextStyle(fontSize: 14),
                  ),
                  contentBorderWidth: 0,
                  contentBorderRadius: 5,
                  rightIcon: const Icon(
                      FluentSystemIcons.ic_fluent_chevron_down_regular),
                  content: const Text(
                      " - Bu dastur orqali siz tadbirlarga ishtirok etib, \"RICOIN\" ya'ni Raqamli iqtisodiyot fakulteti tangalarini qo'lga kiritishingiz va bu tangalarni o'zingiz yoqtirgan sovg'alarga do'konimizda almashtirishingiz mumkin. \n\n - Tadbir oldidan ishtirokchilarga maxsus QR kodlari taqdim etiladi va siz bu QR kodni dastur orqali skaner qilishingiz kerak. Shundan keyin siz tadbir ishtirokchisi hisoblanasiz va tadbir yakunlangach sizga boshqa bir QR kod beriladi bu QR kod tadbirdan chiqish va tadbir uchun ajratilgan tangalarni olish uchun kerak bo'ladi."),
                ),
                AccordionSection(
                  headerBorderRadius: 5,
                  headerPadding: const EdgeInsets.all(12),
                  headerBackgroundColor: Colors.white,
                  header: const Text(
                    "Buyurtmalarni qayerdan olaman?",
                    style: TextStyle(fontSize: 14),
                  ),
                  contentBorderWidth: 0,
                  contentBorderRadius: 5,
                  rightIcon: const Icon(
                      FluentSystemIcons.ic_fluent_chevron_down_regular),
                  content: const Text(
                      " - Siz buyurtmalarni Raqamli iqtisodiyot fakultetining \"Parvoz\" liderlar jamosidan olishingiz mumkin. Buning uchun fakultet binosining 4 qavatidagi 3-xonaga tashrif buyuring va buyurtmalarni oling."),
                ),
                AccordionSection(
                  headerBorderRadius: 5,
                  headerPadding: const EdgeInsets.all(12),
                  headerBackgroundColor: Colors.white,
                  header: const Text(
                    "Dasturda xatoliklar mavjudmi?",
                    style: TextStyle(fontSize: 14),
                  ),
                  contentBorderWidth: 0,
                  contentBorderRadius: 5,
                  rightIcon: const Icon(
                      FluentSystemIcons.ic_fluent_chevron_down_regular),
                  content: const Text(
                      " - Dastur ko'plab testlar orqali tekshirilgan va xatoliklar to'g'irlangan. Lekin sizda dasturda xatoliklar aniqlansa, iltimos, +998 99 768 30 09 raqamiga qo'ng'iroq qiling yoki telegram orqali @mister_xurshidbey ga murojaat qiling."),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                "Dasturchilar",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.all(12),
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      image: const DecorationImage(
                        image: AssetImage("assets/images/xurshidbek.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Xurshidbek Abdulakimov",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Full Stack dasturchi (Flutter, NodeJS)",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.all(12),
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      image: const DecorationImage(
                        image: AssetImage("assets/images/ismoil.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Ismoil Turg'unpo'latov",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Full Stack dasturchi (React, NodeJS)",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Text(
                "G'oya muallifi",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.all(12),
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      image: const DecorationImage(
                        image: AssetImage("assets/images/sohib.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Sohib Maxmadaliyev",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "\"Parvoz\" liderlar jamoasi prezidenti",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
