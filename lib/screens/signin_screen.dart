import 'package:flutter/material.dart';
import 'package:flutter_ricoin_app/services/auth_services.dart';
import 'package:flutter_ricoin_app/screens/signup_screen.dart';
import 'package:flutter_ricoin_app/utils/utils.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  AuthServices authServices = AuthServices();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  void signInUser() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      authServices.signIn(
        context: context,
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
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 100.0),
            child: Column(
              children: [
                TextField(
                  cursorColor: Colors.black,
                  // textCapitalization: TextCapitalization.words,
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "Email",
                    labelStyle: const TextStyle(color: Colors.black),
                    prefixIcon: const Icon(Icons.email),
                    prefixIconColor: Colors.black,
                    label: const Text("Email"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  cursorColor: Colors.black,
                  // textCapitalization: TextCapitalization.words,
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: "Parol",
                    labelStyle: const TextStyle(color: Colors.black),
                    prefixIcon: const Icon(Icons.lock),
                    prefixIconColor: Colors.black,
                    label: const Text("Parol"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: signInUser,
                    child: const Text(
                      "Akkauntga kirish",
                      style: TextStyle(color: Colors.white),
                    )),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUp()),
                    );
                  },
                  child: Text(
                    "Ro'yhatdan o'tish",
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
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
