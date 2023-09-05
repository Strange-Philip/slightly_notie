import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:iconoir_flutter/eye_alt.dart';
import 'package:iconoir_flutter/eye_close.dart';
import 'package:iconoir_flutter/nav_arrow_left.dart';
import 'package:slightly_notie/ui/authentication/signUp.dart';
import 'package:slightly_notie/ui/colors.dart';
import 'package:slightly_notie/ui/components/errorMessage.dart';
import 'package:slightly_notie/ui/components/iconButton.dart';
import 'package:slightly_notie/ui/components/loading.dart';
import 'package:slightly_notie/ui/components/primaryButton.dart';
import 'package:slightly_notie/ui/components/primaryTextField.dart';
import 'package:slightly_notie/ui/components/successMessage.dart';
import 'package:slightly_notie/ui/home/home.dart';
import 'package:slightly_notie/utils/inputFormaters.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormBuilderState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscureText = true;
  bool loading = false;

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
        leading: SlIconButton(
            onTap: () {
              Navigator.pop(context);
            },
            icon: const NavArrowLeft(
              height: 20,
              width: 20,
              color: Colors.white,
            )),
      ),
      resizeToAvoidBottomInset: false,
      body: FormBuilder(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Login",
                style: theme.textTheme.bodyLarge!
                    .copyWith(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                "Welcome back lets get you logged \nin, hope you remember your password 😉",
                style: theme.textTheme.bodyLarge!
                    .copyWith(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 36,
              ),
              PrimaryTextFieldWidget(
                labelText: "Email",
                hintText: "email",
                maxLines: 1,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  return validateEmail(value!);
                },
                controller: emailController,
                onFieldSubmitted: (p0) {
                  FocusScope.of(context).unfocus();
                },
              ),
              const SizedBox(
                height: 20,
              ),
              PrimaryTextFieldWidget(
                labelText: "Password",
                hintText: "password",
                obscureText: obscureText,
                suffix: GestureDetector(
                  onTap: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: obscureText
                        ? const EyeAlt(
                            height: 16,
                            width: 16,
                            color: Colors.white,
                          )
                        : const EyeClose(
                            height: 16,
                            width: 16,
                            color: Colors.white,
                          ),
                  ),
                ),
                maxLines: 1,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  return validatepassword(value!);
                },
                controller: passwordController,
                onFieldSubmitted: (p0) {
                  FocusScope.of(context).unfocus();
                },
              ),
              const Spacer(),
              PrimaryButtonWidget(
                title: "login",
                onPressed: () {
                  _formkey.currentState!.validate();
                  if (_formkey.currentState!.validate() == true) {
                    showLoading(context);

                    FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: emailController.value.text,
                            password: passwordController.value.text)
                        // ignore: body_might_complete_normally_catch_error
                        .catchError((onError) {
                      debugPrint(onError.toString());
                      Navigator.pop(context);
                      showError(context, onError.toString());
                      Timer(const Duration(seconds: 2), () {
                        Navigator.pop(context);
                      });
                    }).then((value) {
                      print("Done");
                      Navigator.pop(context);
                      showSuccess(context);
                      Timer(const Duration(seconds: 2), () {
                        Navigator.pop(context);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const HomePage()),
                          (Route<dynamic> route) => false,
                        );
                      });
                    });
                  } else {
                    showError(context, '');
                    Timer(const Duration(seconds: 2), () {
                      setState(() {
                        loading = false;
                      });
                      Navigator.pop(context);
                    });
                  }
                },
              ),
              const SizedBox(
                height: 18,
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                      text: "Dont't have an account? ",
                      style: theme.textTheme.bodyMedium!
                          .copyWith(fontWeight: FontWeight.w400, fontSize: 16, color: Colors.white),
                      children: [
                        TextSpan(
                          text: 'Sign up',
                          style: theme.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: SlightlyColors.primaryColor),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => const SignUpPage(),
                                ),
                              );
                            },
                        )
                      ]),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showLoading(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: false,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 200),
        child: const Padding(
          padding: EdgeInsets.only(bottom: 25, left: 12, right: 12),
          child: LoadingComponent(
            message: "Logging in 😎",
          ),
        ),
      ),
    );
  }

  void showSuccess(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: false,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 200),
        child: const Padding(
          padding: EdgeInsets.only(bottom: 25, left: 12, right: 12),
          child: SuccessComponent(
            message: "Login Complete😎",
          ),
        ),
      ),
    );
  }

  void showError(BuildContext context, String? message) {
    showModalBottomSheet(
      isScrollControlled: false,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 200),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 25, left: 12, right: 12),
          child: ErrorComponent(
            message: message ?? "Please fill the form correctly 🙁",
          ),
        ),
      ),
    );
  }
}
