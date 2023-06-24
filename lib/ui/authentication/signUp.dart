import 'package:flutter/material.dart';
import 'package:slightly_notie/ui/colors.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
          "Sign Up",
          style: theme.textTheme.bodyLarge!
              .copyWith(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
