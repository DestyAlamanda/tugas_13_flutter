import 'package:flutter/material.dart';
import 'package:tugas13_flutter/auth/login.dart';
import 'package:tugas13_flutter/extension/navigation.dart';
import 'package:tugas13_flutter/preference/share_preference.dart';
import 'package:tugas13_flutter/views/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const id = "/splash_screen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    isLogin();
  }

  void isLogin() async {
    bool? isLogin = await PreferenceHandler.getLogin();

    Future.delayed(Duration(seconds: 3)).then((value) async {
      print(isLogin);
      if (isLogin == true) {
        context.pushReplacementNamed(SiswaHomePage.id);
      } else {
        context.push(LoginPage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(Icons.school), Text("SMA 113")],
        ),
      ),
    );
  }
}
