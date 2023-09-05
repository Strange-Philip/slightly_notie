import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:slightly_notie/ui/authentication/onboarding.dart';
import 'package:slightly_notie/ui/colors.dart';
import 'package:slightly_notie/ui/home/home.dart';

@pragma("vm:entry-point")
void backgroundCallback(Uri? data) async {
  print(data);
  if (data?.host == 'titleclicked') {}
}

const String appGroupId = '<group.slightlynotie>';
const String iOSWidgetName = 'NotesWidget';
const String androidWidgetName = 'NotesWidget';

class AppCore extends StatefulWidget {
  const AppCore({super.key});

  @override
  State<AppCore> createState() => _AppCoreState();
}

class _AppCoreState extends State<AppCore> {
  late StreamSubscription<User?> user;

  @override
  void initState() {
    super.initState();
    HomeWidget.setAppGroupId(appGroupId);
    // HomeWidget.initiallyLaunchedFromHomeWidget().then(_launchedFromWidget);
    HomeWidget.updateWidget(
      iOSName: iOSWidgetName,
      androidName: androidWidgetName,
    );
    // HomeWidget.widgetClicked.listen(_launchedFromWidget);
    HomeWidget.registerBackgroundCallback(backgroundCallback);
    HomeWidget.renderFlutterWidget(
      const AddNoteWidget(),
      key: 'addNoteWidget',
      logicalSize: Size(400, 400),
    );

    user = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        debugPrint('User is currently signed out!');
      } else {
        debugPrint('User is signed in!');
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkForWidgetLaunch();
    HomeWidget.widgetClicked.listen(_launchedFromWidget);
  }

  void _checkForWidgetLaunch() {
    HomeWidget.initiallyLaunchedFromHomeWidget().then(_launchedFromWidget);
  }

  void _launchedFromWidget(Uri? uri) {
    print(uri);
    // Navigator.pushNamed(context, '/addNote');
    if (uri != null) {
      print("opened from widget");
      Navigator.pushNamed(context, '/addNote');
    } else {
      print(uri!.data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FirebaseAuth.instance.currentUser == null ? const OnboardingScreens() : const HomePage();
  }
}

class AddNoteWidget extends StatelessWidget {
  const AddNoteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: SlightlyColors.backgroundBlack,
      child: Center(
          child: Icon(
        Icons.add,
        color: Colors.white,
        size: 50,
      )),
    );
  }
}
