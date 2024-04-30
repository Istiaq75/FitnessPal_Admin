
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/view/Authentication/LoginScreen/login_view.dart';
import 'package:fitness/view/dashboard/navigator.dart';
import 'package:fitness/view/home/home_view.dart';
import 'package:fitness/view/on_boarding/started_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final user = FirebaseAuth.instance;
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    route();
  }

  Future<void> route() async {
    sharedPreferences = await SharedPreferences.getInstance();
    Future.delayed(const Duration(seconds: 5), () {
      user.authStateChanges().listen((event) {
        if (event == null && mounted && !sharedPreferences.containsKey('intro')) {
          sharedPreferences.setBool('intro', true);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const StartedView()),
                  (route) => false);
        } else {
          if (user.currentUser?.email == "istiaq66@gmail.com") {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const BottomNavBar()),
                    (route) => false);
          }else if(sharedPreferences.containsKey('intro') && sharedPreferences.getBool('intro')!){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const LoginView()));
          } else {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => HomeView()),
                    (route) => false);
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/logo.png",
              width: size.width * 0.8,
            ),
          ],
        ),
      ),
    );
  }
}