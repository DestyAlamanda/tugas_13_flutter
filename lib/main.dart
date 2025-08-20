import 'package:flutter/material.dart';
import 'package:tugas13_flutter/auth/login.dart';
import 'package:tugas13_flutter/auth/spalsh_screen.dart';
import 'package:tugas13_flutter/views/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: SplashScreen.id,
      routes: {
        LoginPage.id: (context) => LoginPage(),
        SplashScreen.id: (context) => SplashScreen(),
        SiswaHomePage.id: (context) => SiswaHomePage(),
      },
      // home: BottomNavigator(),
    );
  }
}
