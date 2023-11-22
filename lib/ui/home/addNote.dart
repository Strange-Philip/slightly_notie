import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconoir_flutter/delete_circle.dart';
import 'package:iconoir_flutter/nav_arrow_left.dart';
import 'package:iconoir_flutter/palette.dart';
import 'package:iconoir_flutter/save_floppy_disk.dart';
import 'package:slightly_notie/ui/colors.dart';
import 'package:slightly_notie/ui/components/errorMessage.dart';
import 'package:slightly_notie/ui/components/iconButton.dart';
import 'package:slightly_notie/ui/components/loading.dart';
import 'package:slightly_notie/ui/components/successMessage.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final titleTextController = TextEditingController();
  final noteTextController = TextEditingController();

  final List<Color> colors = [
    SlightlyColors.accentBlue,
    SlightlyColors.accentGreen,
    SlightlyColors.accentYellow,
    SlightlyColors.accentLightBlue,
    SlightlyColors.accentOrange,
    SlightlyColors.accentPink,
    SlightlyColors.accentRed,
  ];
  Color selectedColor = SlightlyColors.accentBlue;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: SlightlyColors.backgroundBlack,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
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
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 10,
              backgroundColor: Color(selectedColor.value),
            ),
          ),
          SlIconButton(
              onTap: () {
                showBtnSheetColor(context);
              },
              icon: const Palette(
                height: 20,
                width: 20,
                color: Colors.white,
              )),
          SlIconButton(
              onTap: () {
                FocusScope.of(context).unfocus();
                showLoading(context);
                String id = FirebaseFirestore.instance.collection('notes').doc().id;
                FirebaseFirestore.instance.collection('notes').doc(id).set({
                  'title': titleTextController.value.text,
                  'note': noteTextController.value.text,
                  'userid': FirebaseAuth.instance.currentUser!.uid,
                  'id': id,
                  'color': selectedColor.value.toString(),
                  'date': DateTime.now().toString()
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
                    Navigator.pop(context);
                  });
                });
              },
              icon: const SaveFloppyDisk(
                height: 20,
                width: 20,
                color: Colors.white,
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 26, 24, 10),
          child: Column(
            children: [
              TextField(
                controller: titleTextController,
                autofocus: true,
                maxLengthEnforcement: MaxLengthEnforcement.none,
                scrollPhysics: const NeverScrollableScrollPhysics(),
                style: const TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter title',
                    hintStyle: theme.textTheme.bodyLarge!
                        .copyWith(color: Colors.white.withOpacity(0.8), fontSize: 40)),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: noteTextController,
                autofocus: false,
                scrollPhysics: const NeverScrollableScrollPhysics(),
                style: theme.textTheme.bodyLarge!.copyWith(color: Colors.white, fontSize: 20),
                minLines: 1,
                maxLines: 50000,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Start writing here...',
                    hintStyle: theme.textTheme.bodyLarge!
                        .copyWith(color: Colors.white.withOpacity(0.4), fontSize: 20)),
              ),
            ],
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
            message: "Note Saved 💪🏾",
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
            message: message ?? "Error saving note 😪",
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
            message: "Saving note😎",
          ),
        ),
      ),
    );
  }

  void showBtnSheetColor(BuildContext context) async {
    final theme = Theme.of(context);

    var result = await showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) =>
          StatefulBuilder(builder: (BuildContext context, StateSetter setBtnState) {
        return ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 350),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 25, left: 12, right: 12),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: SlightlyColors.lightBlack, borderRadius: BorderRadius.circular(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Select Color 🎨",
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
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 200,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    child: GridView.builder(
                        itemCount: colors.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            childAspectRatio: 1,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 15),
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              setBtnState(() {
                                selectedColor = Color(colors[index].value);
                              });
                              Navigator.pop(context, selectedColor);
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: Color(colors[index].value),
                                  borderRadius: BorderRadius.circular(40),
                                  border: Border.all(
                                      color: selectedColor.value == colors[index].value
                                          ? SlightlyColors.primaryColor
                                          : Colors.transparent,
                                      width: 5)),
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
    setState(() {
      selectedColor = result;
    });
  }
}
