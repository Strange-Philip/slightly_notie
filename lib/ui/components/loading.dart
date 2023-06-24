import 'package:flutter/material.dart';
import 'package:slightly_notie/ui/colors.dart';

class LoadingComponent extends StatelessWidget {
  const LoadingComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      constraints: const BoxConstraints(maxHeight: 200, minHeight: 0),
      decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(20)),
      child: Row(children: [
        // Logo animation
        CircularProgressIndicator(
          color: SlightlyColors.primaryColor,
          backgroundColor: Color(0xfff5f5f5),
          strokeWidth: 3,
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Text(
            'Loading... Please hang tight 😉',
            style: theme.textTheme.bodyLarge!.copyWith(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        )
      ]),
    );
  }
}
