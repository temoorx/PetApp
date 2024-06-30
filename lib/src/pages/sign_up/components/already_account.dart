import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:your_app_test/src/theme/palette.dart';

class AlreadyAccount extends StatelessWidget {
  const AlreadyAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Already have an account? ',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pop(context);
              },
          ),
          TextSpan(
            text: 'Sign in',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.bold, fontSize: 14, height: 1.5),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pop(context);
              },
          ),
        ],
      ),
    );
  }
}
