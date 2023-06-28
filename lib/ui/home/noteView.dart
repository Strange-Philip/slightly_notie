import 'dart:async';

import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconoir_flutter/clock.dart';
import 'package:iconoir_flutter/copy.dart';
import 'package:iconoir_flutter/edit.dart';
import 'package:iconoir_flutter/nav_arrow_left.dart';
import 'package:iconoir_flutter/trash.dart';
import 'package:intl/intl.dart';
import 'package:slightly_notie/models/note.dart';
import 'package:slightly_notie/ui/colors.dart';
import 'package:slightly_notie/ui/components/errorMessage.dart';
import 'package:slightly_notie/ui/components/iconButton.dart';
import 'package:slightly_notie/ui/components/loading.dart';
import 'package:slightly_notie/ui/components/primaryButton.dart';
import 'package:slightly_notie/ui/components/secondaryButton.dart';
import 'package:slightly_notie/ui/components/successMessage.dart';
import 'package:slightly_notie/ui/home/editNote.dart';

class NoteViewPage extends StatefulWidget {
  final Note note;
  const NoteViewPage({super.key, required this.note});

  @override
  State<NoteViewPage> createState() => _NoteViewPageState();
}

class _NoteViewPageState extends State<NoteViewPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Color(widget.note.color!),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: false,
        leading: SlIconButton(
            onTap: () {
              Navigator.pop(context);
            },
            lowOpacity: true,
            icon: const NavArrowLeft(
              height: 20,
              width: 20,
              color: Colors.white,
            )),
        actions: [
          SlIconButton(
              onTap: () {
                FlutterClipboard.copy("${widget.note.title}\n${widget.note.note}").then((value) {
                  print('copied');
                  showSuccess(context, "Copied to Clipboard 😇");
                  Timer(const Duration(seconds: 1), () {
                    Navigator.pop(context);
                  });
                });
              },
              lowOpacity: true,
              icon: const Copy(
                height: 20,
                width: 20,
                color: Colors.white,
              )),
          SlIconButton(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => EditNotePage(
                      note: widget.note,
                    ),
                  ),
                );
              },
              lowOpacity: true,
              icon: const Edit(
                height: 20,
                width: 20,
                color: Colors.white,
              )),
          SlIconButton(
              onTap: () {
                showDeleteSheet(context);
              },
              lowOpacity: true,
              icon: const Trash(
                height: 20,
                width: 20,
                color: Colors.white,
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 26, 24, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.note.title!,
              style: theme.textTheme.bodyLarge!
                  .copyWith(color: Colors.black, fontSize: 30, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Clock(height: 20, width: 20, color: Colors.grey.shade800),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  DateFormat.yMMMEd().format(DateTime.parse(widget.note.date!)),
                  style: theme.textTheme.bodyLarge!.copyWith(
                      color: Colors.grey.shade800, fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            const SizedBox(
              height: 6,
            ),
            Expanded(
              child: Text(
                widget.note.note!,
                style: theme.textTheme.bodyLarge!.copyWith(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showSuccess(BuildContext context, String? message) {
    showModalBottomSheet(
      isScrollControlled: false,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 200),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 25, left: 12, right: 12),
          child: SuccessComponent(
            message: message ?? "Copied to Clipboard 😇",
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
            message: "Deleting note 🙁",
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

  void showDeleteSheet(BuildContext context) async {
    final theme = Theme.of(context);
    var result = await showModalBottomSheet(
      isScrollControlled: false,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 350),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 25, left: 12, right: 12),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: SlightlyColors.backgroundBlack, borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: CircleAvatar(
                    backgroundColor: SlightlyColors.primary2,
                    radius: 28,
                    child: const Trash(
                      height: 30,
                      width: 30,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Sure you want to delete note this?🧐\nYou won't have any record of this note.",
                  style: theme.textTheme.bodyLarge!.copyWith(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: PrimaryButtonWidget(
                    title: "Delete",
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: SecondaryButtonWidget(
                    title: "Cancel",
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    if (result == true) {
      FocusScope.of(context).unfocus();
      showLoading(context);
      FirebaseFirestore.instance
          .collection('notes')
          .doc(widget.note.id)
          .delete()
          .onError((error, stackTrace) {
        debugPrint(error.toString());
        Navigator.pop(context);
        showError(context, error.toString());
        Timer(const Duration(seconds: 2), () {
          Navigator.pop(context);
        });
      }).then((value) {
        print("Done");
        Navigator.pop(context);
        showSuccess(context, "Note deleted 🙂");
        Timer(const Duration(seconds: 2), () {
          Navigator.pop(context);
          Navigator.pop(context);
        });
      });
    }
  }
}
