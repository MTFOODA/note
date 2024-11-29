import 'package:flutter/material.dart';
import 'package:note_app/screens/Home_screen.dart';
import 'package:note_app/screens/login_screen.dart';
import 'package:note_app/shared/sp.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    final email = CacheHelper.getData('email');
    final password = CacheHelper.getData('password');

    return (email != null && password != null)
        ? const HomeScreen()
        : LoginScreen();
  }
}