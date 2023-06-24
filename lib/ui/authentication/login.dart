import 'package:flutter/material.dart';
import 'package:slightly_notie/ui/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: SlightlyColors.backgroundBlack,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Text(
          "Login",
          style: theme.textTheme.bodyLarge!
              .copyWith(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
