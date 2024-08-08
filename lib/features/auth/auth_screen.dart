// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:quick_merchant_windows/app.dart';
import 'package:quick_merchant_windows/core/locale/my_locale.dart';
import 'package:quick_merchant_windows/core/models/user.dart';
import 'package:quick_merchant_windows/core/services/auth/auth_services.dart';
import 'package:quick_merchant_windows/features/web/web_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController usernameController =
      TextEditingController.fromValue(
          const TextEditingValue(text: 'ykkojunctioncity1'));
  final TextEditingController passwordController =
      TextEditingController.fromValue(
          const TextEditingValue(text: 'Quick@123'));

  User? user;
  void login() async {
    final user = await AuthServices.login(
        usernameController.text.trim(), passwordController.text.trim());
    print(user);
    if (user != null) {
      setState(() {
        this.user = user;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return user != null
        ? ExampleBrowser()
        : Scaffold(
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
              // width: App.screenwidth,
              // height: App.screenHeight,
              child: Center(
                // decoration: BoxDecoration(color: App.colorSchema.surface),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _TitleAndTextField(
                      controller: usernameController,
                      title: MyLocale.username,
                      hintText: MyLocale.enterUsername,
                    ),
                    _TitleAndTextField(
                      controller: passwordController,
                      title: MyLocale.password,
                      hintText: MyLocale.enterPassword,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      width: App.screenwidth,
                      child: ElevatedButton(
                        onPressed: login,
                        child: Text(MyLocale.login),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

class _TitleAndTextField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String hintText;
  const _TitleAndTextField({
    required this.controller,
    required this.title,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: App.textTheme.titleMedium,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
          decoration: BoxDecoration(
            color: App.containerColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              hintText: hintText,
            ),
          ),
        ),
      ],
    );
  }
}
