import 'package:flutter/material.dart';
import 'package:slightly_notie/ui/colors.dart';

class SlIconButton extends StatelessWidget {
  final Widget icon;
  final bool lowOpacity;
  final Function()? onTap;
  const SlIconButton({super.key, required this.icon, this.onTap, this.lowOpacity = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 40,
          width: 40,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              color: lowOpacity
                  ? SlightlyColors.lightBlack.withOpacity(0.5)
                  : SlightlyColors.lightBlack,
              borderRadius: BorderRadius.circular(10)),
          child: icon,
        ),
      ),
    );
  }
}
