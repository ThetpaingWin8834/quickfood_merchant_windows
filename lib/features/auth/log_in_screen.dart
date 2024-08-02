// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:quick_merchant_windows/app.dart';
import 'package:quick_merchant_windows/core/locale/my_locale.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 32),
        width: App.screenwidth,
        height: App.screenHeight,
        child: Column(
          children: [
            _TitleAndTextField(),
          ],
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
    Key? key,
    required this.controller,
    required this.title,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            MyLocale.username,
            style: App.textTheme.titleMedium,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 6),
          decoration: BoxDecoration(
            color: App.containerColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              hintText: MyLocale.enterUsername,
            ),
          ),
        ),
      ],
    );
  }
}
