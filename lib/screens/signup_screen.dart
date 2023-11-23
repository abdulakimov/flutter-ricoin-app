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
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 100.0),
            child: Column(
              children: [
                TextField(
                  cursorColor: Colors.black,
                  textCapitalization: TextCapitalization.words,
                  controller: nameController,
                  decoration: InputDecoration(
                    fillColor: Colors.black,
                    hintText: "m.u: Xurshidbek",
                    labelStyle: const TextStyle(color: Colors.black),
                    prefixIcon: const Icon(Icons.person),
                    prefixIconColor: Colors.black,
                    label: const Text("Ism"),
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
                  textCapitalization: TextCapitalization.words,
                  controller: surnameController,
                  decoration: InputDecoration(
                    hintText: "m.u: Abdulakimov",
                    labelStyle: const TextStyle(color: Colors.black),
                    prefixIcon: const Icon(Icons.person),
                    prefixIconColor: Colors.black,
                    label: const Text("Familiya"),
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
                  height: 30,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignIn()),
                    );
                  },
                  child: Text(
                    "Akkountga kirish",
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
