import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:slightly_notie/ui/colors.dart';

class LoadingComponent extends StatelessWidget {
  final String? message;
  const LoadingComponent({super.key, this.message});

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
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: CircularProgressIndicator(
            color: SlightlyColors.primaryColor,
            backgroundColor: Color(0xfff5f5f5),
            strokeWidth: 3,
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Text(
            message ?? 'Loading... Please hang tight 😉',
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

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: SlightlyColors.backgroundBlack,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: SlightlyColors.primaryColor,
                strokeWidth: 2,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Text(
              'Loading ...',
              style: theme.textTheme.bodyLarge!
                  .copyWith(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}

class Empty extends StatelessWidget {
  const Empty({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: SlightlyColors.backgroundBlack,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 250,
              height: 250,
              child: SvgPicture.asset(
                "images/empty.svg",
                color: SlightlyColors.fullWhite,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'No notes yet... tap on the button below to \nadd tour first note 😎',
              style: theme.textTheme.bodyLarge!
                  .copyWith(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
