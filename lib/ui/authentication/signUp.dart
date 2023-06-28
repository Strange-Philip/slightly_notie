import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:iconoir_flutter/eye_alt.dart';
import 'package:iconoir_flutter/eye_close.dart';
import 'package:iconoir_flutter/nav_arrow_left.dart';
import 'package:slightly_notie/ui/authentication/login.dart';
import 'package:slightly_notie/ui/colors.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:slightly_notie/ui/components/errorMessage.dart';
import 'package:slightly_notie/ui/components/iconButton.dart';
import 'package:slightly_notie/ui/components/loading.dart';
import 'package:slightly_notie/ui/components/primaryButton.dart';
import 'package:slightly_notie/ui/components/primaryTextField.dart';
import 'package:slightly_notie/ui/components/successMessage.dart';
import 'package:slightly_notie/utils/inputFormaters.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formkey = GlobalKey<FormBuilderState>();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool obscureText = true;
  bool obscureText2 = true;
  bool loading = false;
  String? password;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: SlightlyColors.backgroundBlack,
      resizeToAvoidBottomInset: false,
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
      body: FormBuilder(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Sign Up",
                style: theme.textTheme.bodyLarge!
                    .copyWith(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                "Fill out the form to register and you would \nstart taking notes in no time 🤩",
                style: theme.textTheme.bodyLarge!
                    .copyWith(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 36,
              ),
              PrimaryTextFieldWidget(
                labelText: "Full name",
                hintText: "John Doe",
                maxLines: 1,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  return validatename(value!);
                },
                controller: fullNameController,
                onFieldSubmitted: (p0) {
                  FocusScope.of(context).unfocus();
                },
              ),
              const SizedBox(
                height: 20,
              ),
              PrimaryTextFieldWidget(
                labelText: "Email",
                hintText: "email",
                maxLines: 1,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  return validateEmail(value!);
                },
                keyboardType: TextInputType.emailAddress,
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
                onChanged: (p0) {
                  password = p0;
                },
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
              const SizedBox(
                height: 20,
              ),
              PrimaryTextFieldWidget(
                labelText: "Confirm Password",
                hintText: "password",
                obscureText: obscureText2,
                suffix: GestureDetector(
                  onTap: () {
                    setState(() {
                      obscureText2 = !obscureText2;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: obscureText2
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
                  return comfirmpassword(value!, password!);
                },
                controller: confirmPasswordController,
                onFieldSubmitted: (p0) {
                  FocusScope.of(context).unfocus();
                },
              ),
              const Spacer(),
              PrimaryButtonWidget(
                title: "Sign up",
                onPressed: () {
                  _formkey.currentState!.validate();
                  if (_formkey.currentState!.validate() == true) {
                    showLoading(context);
                    FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: emailController.value.text,
                            password: passwordController.value.text)
                        .then((value) {
                      FirebaseAuth.instance.currentUser!
                          .updateDisplayName(fullNameController.value.text);

                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .set({
                        'userName': fullNameController.value.text,
                        'email': emailController.value.text,
                        'userid': FirebaseAuth.instance.currentUser!.uid,
                        'dateAdded': DateTime.now().toString()
                      }).onError((error, stackTrace) {
                        debugPrint(error.toString());
                        Navigator.pop(context);
                        showError(context, error.toString());
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
                            MaterialPageRoute(builder: (context) => const LoginPage()),
                            (Route<dynamic> route) => false,
                          );
                        });
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
                      text: "Already have an account? ",
                      style: theme.textTheme.bodyMedium!
                          .copyWith(fontWeight: FontWeight.w400, fontSize: 16, color: Colors.white),
                      children: [
                        TextSpan(
                          text: 'Log in',
                          style: theme.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: SlightlyColors.primaryColor),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => const LoginPage(),
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
            message: "Signing you up 😎",
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
            message: "Sign Up done, Login now 😎",
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
