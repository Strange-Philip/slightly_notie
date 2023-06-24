import 'package:flutter/material.dart';
import 'package:iconoir_flutter/clock.dart';
import 'package:slightly_notie/models/note.dart';
import 'package:slightly_notie/ui/colors.dart';
import 'package:slightly_notie/ui/home/noteView.dart';
import 'package:slightly_notie/utils/hextoColor.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  const NoteCard({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => NoteViewPage(
                note: note,
              ),
            ),
          );
        },
        child: Container(
          height: 150,
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Color(note.color!),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title!,
                style: theme.textTheme.bodyLarge!
                    .copyWith(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Clock(height: 16, width: 16, color: Colors.grey.shade800),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    note.date!,
                    style: theme.textTheme.bodyLarge!.copyWith(
                        color: Colors.grey.shade800, fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                note.note!,
                maxLines: 3,
                style: theme.textTheme.bodyLarge!.copyWith(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
