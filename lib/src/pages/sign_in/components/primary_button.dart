import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_app_test/src/theme/palette.dart';
import 'package:your_app_test/src/theme/theme.dart';

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
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.06,
        width: double.infinity,
        decoration: BoxDecoration(
          color: MyTheme.isDark ? Palette.white : Palette.black,
          borderRadius: BorderRadius.circular(90),
        ),
        child: Center(child: child),
      ),
    );
  }
}
