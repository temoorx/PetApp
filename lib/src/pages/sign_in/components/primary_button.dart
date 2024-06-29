import 'package:flutter/material.dart';
import 'package:your_app_test/src/theme/palette.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Palette.black,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(90)),
        ),
        onPressed: onPressed,
        child: child);
  }
}
