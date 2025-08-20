import 'package:flutter/material.dart';
import 'package:tugas13_flutter/auth/login.dart';
import 'package:tugas13_flutter/extension/navigation.dart';
import 'package:tugas13_flutter/preference/share_preference.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        PreferenceHandler.removeLogin();
        context.pushReplacementNamed(LoginPage.id);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF1A2A80),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
      ),
      child: Text(
        "Keluar",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
