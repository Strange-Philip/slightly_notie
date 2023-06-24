import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:slightly_notie/ui/authentication/signUp.dart';
import 'package:slightly_notie/ui/colors.dart';
import 'package:slightly_notie/ui/components/primaryButton.dart';
import 'package:slightly_notie/ui/components/secondaryButton.dart';

import 'login.dart';

class OnboardingScreens extends StatefulWidget {
  const OnboardingScreens({super.key});

  @override
  State<OnboardingScreens> createState() => _OnboardingScreensState();
}

class _OnboardingScreensState extends State<OnboardingScreens> {
  PageController? _pageController;
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: SlightlyColors.backgroundBlack,
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 150),
          child: PageView(
            controller: _pageController,
            onPageChanged: onChangedFunction,
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              SizedBox(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: SvgPicture.asset(
                        "images/strength.svg",
                        width: 250,
                        height: 250,
                        color: Colors.white,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: SvgPicture.asset(
                        "images/writing.svg",
                        width: 250,
                        height: 250,
                        color: Colors.white,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * 0.25,
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Indicator(
                  positionIndex: 0,
                  currentIndex: currentIndex,
                ),
                const SizedBox(
                  width: 6,
                ),
                Indicator(
                  positionIndex: 1,
                  currentIndex: currentIndex,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.74, left: 25, right: 25),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                currentIndex == 1 ? "All thoughts.One place." : "Welcome to Slightly Notie",
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium!
                    .copyWith(fontSize: 26, fontWeight: FontWeight.w600, color: Colors.white),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.3, left: 25, right: 25),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                currentIndex == 1
                    ? "Dive right in and clear that mind of yours by writing your thoughts down."
                    : "We're thrilled to have you on board. Happy note-taking!",
                textAlign: TextAlign.center,
                maxLines: 3,
                style: theme.textTheme.bodySmall!
                    .copyWith(fontSize: 16, color: SlightlyColors.primary2),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * 0.15,
            left: 36,
            right: 36,
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: PrimaryButtonWidget(
              title: "Register",
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const SignUpPage(),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * 0.07,
            left: 36,
            right: 36,
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SecondaryButtonWidget(
              title: "Sign in",
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const LoginPage(),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  onChangedFunction(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  nextFunction() {
    _pageController!.nextPage(duration: const Duration(milliseconds: 350), curve: Curves.ease);
  }

  skipFunction() {
    _pageController!.jumpToPage(2);
  }
}

class Indicator extends StatelessWidget {
  final int positionIndex, currentIndex;
  const Indicator({Key? key, required this.currentIndex, required this.positionIndex})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8,
      width: 40,
      decoration: BoxDecoration(
          color:
              positionIndex == currentIndex ? SlightlyColors.primaryColor : SlightlyColors.primary2,
          borderRadius: BorderRadius.circular(10)),
    );
  }
}
