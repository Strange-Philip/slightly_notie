import 'package:flutter/material.dart';
import 'package:iconoir_flutter/add_circle.dart';
import 'package:iconoir_flutter/info_empty.dart';
import 'package:iconoir_flutter/user.dart';
import 'package:slightly_notie/models/note.dart';
import 'package:slightly_notie/ui/colors.dart';
import 'package:slightly_notie/ui/components/iconButton.dart';
import 'package:slightly_notie/ui/components/loading.dart';
import 'package:slightly_notie/ui/components/noteCard.dart';
import 'package:slightly_notie/ui/home/addNote.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            icon: const User(
              height: 20,
              width: 20,
              color: Colors.white,
            ),
            onTap: () {
              showLoading(context);
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
        child: ListView(
          children: [
            NoteCard(
              note: Note(
                  title: "New note",
                  date: "20th Nov",
                  color: SlightlyColors.accentBlue.value,
                  note:
                      "Commodo eiusmod elit qui magna anim enim nostrud deserunt tempor sint ad non. Exercitation cillum quis voluptate excepteur veniam fugiat deserunt esse commodo officia culpa. Ad enim ut adipisicing laborum consectetur mollit voluptate aliquip consequat Lorem ad velit consectetur."),
            ),
            NoteCard(
              note: Note(
                  title: "New note",
                  date: "20th Nov",
                  color: SlightlyColors.accentPink.value,
                  note:
                      "Commodo eiusmod elit qui magna anim enim nostrud deserunt tempor sint ad non. Exercitation cillum quis voluptate excepteur veniam fugiat deserunt esse commodo officia culpa. Ad enim ut adipisicing laborum consectetur mollit voluptate aliquip consequat Lorem ad velit consectetur."),
            ),
            NoteCard(
              note: Note(
                  title: "New note",
                  date: "20th Nov",
                  color: SlightlyColors.accentGreen.value,
                  note:
                      "Commodo eiusmod elit qui magna anim enim nostrud deserunt tempor sint ad non. Exercitation cillum quis voluptate excepteur veniam fugiat deserunt esse commodo officia culpa. Ad enim ut adipisicing laborum consectetur mollit voluptate aliquip consequat Lorem ad velit consectetur."),
            ),
            NoteCard(
              note: Note(
                  title: "New note",
                  date: "20th Nov",
                  color: SlightlyColors.accentYellow.value,
                  note:
                      "Commodo eiusmod elit qui magna anim enim nostrud deserunt tempor sint ad non. Exercitation cillum quis voluptate excepteur veniam fugiat deserunt esse commodo officia culpa. Ad enim ut adipisicing laborum consectetur mollit voluptate aliquip consequat Lorem ad velit consectetur."),
            ),
            NoteCard(
              note: Note(
                  title: "New note",
                  date: "20th Nov",
                  color: SlightlyColors.accentOrange.value,
                  note:
                      "Commodo eiusmod elit qui magna anim enim nostrud deserunt tempor sint ad non. Exercitation cillum quis voluptate excepteur veniam fugiat deserunt esse commodo officia culpa. Ad enim ut adipisicing laborum consectetur mollit voluptate aliquip consequat Lorem ad velit consectetur."),
            ),
            NoteCard(
              note: Note(
                  title: "New note",
                  date: "20th Nov",
                  color: SlightlyColors.accentLightBlue.value,
                  note:
                      "Commodo eiusmod elit qui magna anim enim nostrud deserunt tempor sint ad non. Exercitation cillum quis voluptate excepteur veniam fugiat deserunt esse commodo officia culpa. Ad enim ut adipisicing laborum consectetur mollit voluptate aliquip consequat Lorem ad velit consectetur."),
            ),
            NoteCard(
              note: Note(
                  title: "New note",
                  date: "20th Nov",
                  color: SlightlyColors.accentRed.value,
                  note:
                      "Commodo eiusmod elit qui magna anim enim nostrud deserunt tempor sint ad non. Exercitation cillum quis voluptate excepteur veniam fugiat deserunt esse commodo officia culpa. Ad enim ut adipisicing laborum consectetur mollit voluptate aliquip consequat Lorem ad velit consectetur."),
            ),
          ],
        ),
      ),
    );
  }

  void showBtnSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 300),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 25, left: 12, right: 12),
          child: Container(
            decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
    );
  }

  void showLoading(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 200),
        child: const Padding(
          padding: EdgeInsets.only(bottom: 25, left: 12, right: 12),
          child: LoadingComponent(),
        ),
      ),
    );
  }
}
