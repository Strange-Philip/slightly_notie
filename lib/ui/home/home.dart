import 'package:flutter/material.dart';
import 'package:iconoir_flutter/add_circle.dart';
import 'package:iconoir_flutter/info_empty.dart';
import 'package:iconoir_flutter/user.dart';
import 'package:slightly_notie/ui/colors.dart';
import 'package:slightly_notie/ui/components/iconButton.dart';
import 'package:slightly_notie/ui/components/loading.dart';
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
            icon: User(
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
