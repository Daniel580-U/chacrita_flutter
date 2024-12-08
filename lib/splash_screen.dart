import 'dart:async';
import 'package:chacrita/features/index/pages/index_page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: (2 * 1000).round()), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const IndexPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: content(),
    );
  }

  Widget content() {
    return Center(
      child: Container(
        child: Lottie.asset("assets/img/logo_animation.json"),
      ),
    );
  }
} 