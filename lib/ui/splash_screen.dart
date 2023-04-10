import 'package:flutter/material.dart';

import '../firebase_services/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SplashServices splashscreen = SplashServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashscreen.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.network("https://previews.123rf.com/images/sentavio/sentavio1610/sentavio161000652/64110760-linear-flat-online-shopping-website-hero-image-vector-illustration-e-commerce-business-sale-and.jpg",
        fit: BoxFit.cover,
        )
      ),
    );
  }
}
