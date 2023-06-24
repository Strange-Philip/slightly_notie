import 'package:flutter/material.dart';
import 'package:slightly_notie/ui/colors.dart';

class PrimaryButtonWidget extends StatefulWidget {
  final String title;
  final Function()? onPressed;
  final bool isEnabled;

  const PrimaryButtonWidget(
      {super.key, required this.title, this.onPressed, this.isEnabled = true});

  @override
  State<PrimaryButtonWidget> createState() => _PrimaryButtonWidgetState();
}

class _PrimaryButtonWidgetState extends State<PrimaryButtonWidget> {
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
          color: widget.isEnabled ? SlightlyColors.primaryColor : SlightlyColors.lightBlack,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          widget.title,
          style: theme.textTheme.titleMedium!.copyWith(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
