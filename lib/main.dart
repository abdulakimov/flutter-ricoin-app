import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_ricoin_app/dependency_injection.dart';
import 'package:flutter_ricoin_app/services/auth_services.dart';
import 'package:flutter_ricoin_app/providers/user_provider.dart';
import 'package:flutter_ricoin_app/screens/signin_screen.dart';
import 'package:flutter_ricoin_app/screens/main_screen.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  // ignore: deprecated_member_use
  FlutterNativeSplash.removeAfter(initialization);

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),
    ], child: const MyApp()),
  );
  
  
  DependencyInjection.init();
}

Future initialization(BuildContext? context) async {
  // load all resources
  AuthServices authServices = AuthServices();
  await authServices.getUserData(context!);

  await Future.delayed(const Duration(milliseconds: 1));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthServices authServices = AuthServices();
  @override
  void initState() {
    authServices.getUserData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ricoin App',
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(Theme.of(context).textTheme),
        useMaterial3: true,
      ),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? const MainScreen()
          : const SignIn(),
    );
  }
}
