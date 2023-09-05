import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:iconoir_flutter/add_circle.dart';
import 'package:iconoir_flutter/delete_circle.dart';
import 'package:iconoir_flutter/info_empty.dart';
import 'package:iconoir_flutter/people_tag.dart';
import 'package:slightly_notie/app.dart';
import 'package:slightly_notie/models/note.dart';
import 'package:slightly_notie/ui/colors.dart';
import 'package:slightly_notie/ui/components/errorMessage.dart';
import 'package:slightly_notie/ui/components/iconButton.dart';
import 'package:slightly_notie/ui/components/loading.dart';
import 'package:slightly_notie/ui/components/noteCard.dart';
import 'package:slightly_notie/ui/components/primaryButton.dart';
import 'package:slightly_notie/ui/components/successMessage.dart';
import 'package:slightly_notie/ui/home/addNote.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';
import 'dart:io' show Platform;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

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
          "Notes",
          style: theme.textTheme.bodyLarge!
              .copyWith(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w400),
        ),
        actions: [
          SlIconButton(
            icon: const PeopleTag(
              height: 20,
              width: 20,
              color: Colors.white,
            ),
            onTap: () {
              showUserBtnSheet(context);
            },
          ),
          SlIconButton(
              onTap: () {
                showBtnSheet(context);
              },
              icon: const InfoEmpty(
                height: 20,
                width: 20,
                color: Colors.white,
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const AddNotePage(),
              ),
            );
          },
          backgroundColor: SlightlyColors.primaryColor,
          elevation: 0.2,
          icon: const AddCircle(
            height: 20,
            width: 20,
            color: Colors.white,
          ),
          label: Text(
            "New",
            style: theme.textTheme.bodyLarge!
                .copyWith(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
          )),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 26, 24, 10),
        child: StreamBuilder(
            stream: firebaseFirestore
                .collection('notes')
                .where('userid', isEqualTo: firebaseAuth.currentUser!.uid)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Loading();
              } else if (snapshot.hasData) {
                return snapshot.data!.docs.isEmpty
                    ? const Empty()
                    : SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: snapshot.data!.docs
                              .map((e) => buildCards(Note.fromJson(e.data())))
                              .toList(),
                        ),
                      );
              }
              return const Empty();
            }),
      ),
    );
  }

  void showBtnSheet(BuildContext context) {
    final theme = Theme.of(context);
    UrlLauncherPlatform launcher = UrlLauncherPlatform.instance;

    Future<void> lunchSiteAndroid(String url) async {
      if (!await launcher.launch(
        url,
        useSafariVC: false,
        useWebView: false,
        enableJavaScript: false,
        enableDomStorage: false,
        universalLinksOnly: false,
        headers: <String, String>{},
      )) {
        throw 'Could not launch $url';
      }
    }

    Future<void> lunchSiteIos(String url) async {
      final UrlLauncherPlatform launcher = UrlLauncherPlatform.instance;
      if (await launcher.canLaunch(url)) {
        print(url);
        await launcher.launch(
          url,
          useSafariVC: false,
          useWebView: false,
          enableJavaScript: false,
          enableDomStorage: false,
          universalLinksOnly: false,
          headers: <String, String>{'my_header_key': 'my_header_value'},
        );
      } else {
        throw 'Could not launch $url';
      }
    }

    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 300),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 18, left: 12, right: 12),
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
            decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "App details 🗒️",
                        style: theme.textTheme.bodyLarge!.copyWith(
                            color: Colors.white, fontSize: 24, fontWeight: FontWeight.w400),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const DeleteCircle(
                          color: Colors.white,
                          height: 28,
                          width: 28,
                        ),
                      )
                    ],
                  ),
                ),
                Spacer(),
                Text(
                  "Slightly Notie: Effortlessly capture and organize your thoughts on the go with this sleek and intuitive note-taking app. Stay productive with its smart features and customizable interface.",
                  style: theme.textTheme.bodyLarge!
                      .copyWith(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
                ),
                RichText(
                  text: TextSpan(
                      text: "\nIllustrations from ",
                      style: theme.textTheme.bodyMedium!
                          .copyWith(fontWeight: FontWeight.w400, fontSize: 16, color: Colors.white),
                      children: [
                        TextSpan(
                          text: "https://www.thedoodlelibrary.com/",
                          style: theme.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: SlightlyColors.primaryColor,
                              decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pop(context);
                              if (Platform.isAndroid) {
                                lunchSiteAndroid("https://www.thedoodlelibrary.com/");
                              } else if (Platform.isIOS) {
                                lunchSiteIos("https://www.thedoodlelibrary.com/");
                              }
                            },
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showUserBtnSheet(BuildContext context) {
    final theme = Theme.of(context);

    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 300),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 25, left: 12, right: 12),
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
            decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "User details 🙂",
                        style: theme.textTheme.bodyLarge!.copyWith(
                            color: Colors.white, fontSize: 24, fontWeight: FontWeight.w400),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const DeleteCircle(
                          color: Colors.white,
                          height: 28,
                          width: 28,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Username: " + FirebaseAuth.instance.currentUser!.displayName!,
                  style: theme.textTheme.bodyLarge!
                      .copyWith(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Email: " + FirebaseAuth.instance.currentUser!.email!,
                  style: theme.textTheme.bodyLarge!
                      .copyWith(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w400),
                ),
                Spacer(),
                PrimaryButtonWidget(
                  title: "Logout",
                  onPressed: () async {
                    // Navigator.pop(context);
                    showLoading(context);
                    await FirebaseAuth.instance
                        .signOut()
                        .then((value) {
                          Navigator.pop(context);
                          showSuccess(
                            context,
                          );
                          Timer(const Duration(seconds: 2), () {
                            Navigator.pop(context);
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => const AppCore()),
                              (Route<dynamic> route) => false,
                            );
                          });

                          print("Done");
                        })
                        .whenComplete(() {})
                        .onError((error, stackTrace) {
                          Navigator.pop(context);
                          showError(context, "$error");
                          Timer(const Duration(seconds: 2), () {
                            Navigator.pop(context);
                          });
                        });
                  },
                )
              ],
            ),
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
            message: "User Signed Out 😇",
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
            message: message ?? "Error updating note 😪",
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
            message: "Logging out😎",
          ),
        ),
      ),
    );
  }
}

Widget buildCards(Note note) {
  return NoteCard(
    note: note,
  );
}
