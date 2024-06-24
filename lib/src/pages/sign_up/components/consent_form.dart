import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:your_app_test/src/constant/route_constants.dart';
import 'package:your_app_test/src/theme/get_theme_color.dart';
import 'package:your_app_test/src/theme/lighten_darken_color.dart';
import 'package:your_app_test/src/util/navigation_util.dart';

class ConsentForm extends StatefulWidget {
  const ConsentForm({super.key});

  @override
  State<ConsentForm> createState() => _ConsentFormState();
}

class _ConsentFormState extends State<ConsentForm> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isChecked = !isChecked;
            });
          },
          child: Icon(
            Icons.check_circle,
            color: (isChecked)
                ? getThemeColor(context)
                : darken(getThemeColor(context), 0.25),
          ),
        ),
        RichText(
          text: TextSpan(
            text: '  I agree to the ',
            children: [
              TextSpan(
                text: 'Consent Form',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.lightBlue),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    NavigationUtil.push(
                      context,
                      RouteConstants.consentFormRoute,
                    );
                  },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
