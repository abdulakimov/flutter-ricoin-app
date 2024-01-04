import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ricoin_app/services/auth_services.dart';
import 'package:flutter_ricoin_app/screens/signin_screen.dart';
import 'package:flutter_ricoin_app/utils/utils.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  AuthServices authServices = AuthServices();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    surnameController.dispose();

    super.dispose();
  }

  void signUpUser() async {
    if (surnameController.text.isNotEmpty &&
        nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      authServices.signUp(
        context: context,
        name: nameController.text.trim(),
        surname: surnameController.text.trim(),
        email: emailController.text.trim().toLowerCase(),
        password: passwordController.text.trim().toLowerCase(),
      );
    } else {
      showSnackBar(context, "Bo'sh joylarni to'ldiring");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50.0),
            child: Column(
              children: [
                const Icon(
                  Icons.fingerprint,
                  size: 150,
                  color: Color(0xFF20095F),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Ro'yhatdan o'ting",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  cursorColor: const Color(0xFF20095F),
                  textCapitalization: TextCapitalization.words,
                  controller: nameController,
                  decoration: InputDecoration(
                    fillColor: const Color(0xFF20095F),
                    hintText: "m.u: Xurshidbek",
                    labelStyle: const TextStyle(color: Color(0xFF20095F)),
                    prefixIcon: const Icon(Icons.person),
                    prefixIconColor: const Color(0xFF20095F),
                    label: const Text("Ism"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF20095F), width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  cursorColor: const Color(0xFF20095F),
                  textCapitalization: TextCapitalization.words,
                  controller: surnameController,
                  decoration: InputDecoration(
                    hintText: "m.u: Abdulakimov",
                    labelStyle: const TextStyle(color: Color(0xFF20095F)),
                    prefixIcon: const Icon(Icons.person),
                    prefixIconColor: const Color(0xFF20095F),
                    label: const Text("Familiya"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF20095F), width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  cursorColor: const Color(0xFF20095F),
                  // textCapitalization: TextCapitalization.words,
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "Email",
                    labelStyle: const TextStyle(color: Color(0xFF20095F)),
                    prefixIcon: const Icon(Icons.email),
                    prefixIconColor: const Color(0xFF20095F),
                    label: const Text("Email"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF20095F), width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  cursorColor: const Color(0xFF20095F),
                  // textCapitalization: TextCapitalization.words,
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: "Parol",
                    labelStyle: const TextStyle(color: Color(0xFF20095F)),
                    prefixIcon: const Icon(Icons.lock),
                    prefixIconColor: const Color(0xFF20095F),
                    label: const Text("Parol"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF20095F), width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF20095F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: signUpUser,
                    child: const Text(
                      "Ro'yhatdan o'tish",
                      style: TextStyle(color: Colors.white),
                    )),
                TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      CupertinoPageRoute(builder: (context) => const SignIn()),
                      (route) => false,
                    );
                  },
                  child: const Text(
                    "Akkountga kirish",
                    style: TextStyle(color: Color(0xFF20095F), fontSize: 13),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
