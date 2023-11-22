import 'package:flutter/material.dart';
import 'package:slightly_notie/ui/colors.dart';

class SecondaryButtonWidget extends StatefulWidget {
  final String title;
  final Function()? onPressed;
  final bool isEnabled;

  const SecondaryButtonWidget(
      {super.key, required this.title, this.onPressed, this.isEnabled = true});

  @override
  State<SecondaryButtonWidget> createState() => _SecondaryButtonWidgetState();
}

class _SecondaryButtonWidgetState extends State<SecondaryButtonWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        width: double.infinity,
        height: 56,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: SlightlyColors.primaryColor, width: 0.5)),
        child: Text(widget.title, style: theme.textTheme.titleMedium!),
      ),
    );
  }
}
