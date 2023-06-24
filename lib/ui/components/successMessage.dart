import 'package:flutter/material.dart';
import 'package:iconoir_flutter/check_circle.dart';
import 'package:slightly_notie/ui/colors.dart';

class SuccessComponent extends StatelessWidget {
  final String? message;
  const SuccessComponent({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      constraints: const BoxConstraints(maxHeight: 200, minHeight: 0),
      decoration: BoxDecoration(
          color: SlightlyColors.backgroundBlack, borderRadius: BorderRadius.circular(20)),
      child: Row(children: [
        // Logo animation
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: CheckCircle(
            color: Colors.green,
            height: 24,
            width: 24,
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Text(
            message ?? 'Success 🥳',
            style: theme.textTheme.bodyLarge!.copyWith(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ),
      ]),
    );
  }
}
