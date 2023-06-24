import 'package:flutter/material.dart';
import 'package:iconoir_flutter/nav_arrow_left.dart';
import 'package:iconoir_flutter/palette.dart';
import 'package:iconoir_flutter/save_floppy_disk.dart';
import 'package:slightly_notie/ui/colors.dart';
import 'package:slightly_notie/ui/components/iconButton.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
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
        actions: const [
          SlIconButton(
              icon: Palette(
            height: 20,
            width: 20,
            color: Colors.white,
          )),
          SlIconButton(
              icon: SaveFloppyDisk(
            height: 20,
            width: 20,
            color: Colors.white,
          )),
        ],
      ),
    );
  }
}
