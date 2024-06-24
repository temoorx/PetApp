import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:your_app_test/src/components/text_field_component.dart';
import 'package:your_app_test/src/constant/assets_constants.dart';
import 'package:your_app_test/src/theme/palette.dart';
import 'package:your_app_test/src/constant/route_constants.dart';
import 'package:your_app_test/src/constant/string_constants.dart';

class NewPasswordBody extends StatelessWidget {
  const NewPasswordBody({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController passwordController = TextEditingController();
    TextEditingController newPasswordController = TextEditingController();

    return Column(
      children: [
        const SizedBox(height: 20),
        TextFormFieldComponent(
          onChanged: (value) {},
          controller: passwordController,
          hintText: 'New Password',
        ),
        TextFormFieldComponent(
          onChanged: (value) {},
          controller: newPasswordController,
          hintText: 'Confirm Password',
        ),
        const SizedBox(height: 20),
        ElevatedButton(
            onPressed: () {
              //blur the screen and show the pop up
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 5,
                      sigmaY: 5,
                    ),
                    child: Container(
                      color: Palette.white.withOpacity(0.2),
                      child: customDialog(
                        title: StringConstants.passwordChanged,
                        description: StringConstants.passwordChangedDescription,
                        buttonText: StringConstants.backtoLogin,
                        onPressed: () {
                          context.router.pushNamed(RouteConstants.signInRoute);
                        },
                      ),
                    ),
                  );
                },
              );
            },
            child: Text(
              StringConstants.save,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Palette.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
            )),
        const SizedBox(height: 20),
        _rememberPassword(context),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _rememberPassword(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: StringConstants.rememberPassword,
        style: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: Palette.subTextColor),
        children: [
          TextSpan(
            text: StringConstants.login,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Palette.primaryColor),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                context.router.pushNamed(RouteConstants.signInRoute);
              },
          ),
        ],
      ),
    );
  }

  Widget customDialog(
      {required String title,
      required String description,
      required String buttonText,
      required VoidCallback onPressed}) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              AssetsConstants.successIcon,
              height: 100,
              width: 100,
            ),
            const SizedBox(height: 20),
            Text(title,
                style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: Palette.black)),
            const SizedBox(height: 20),
            Text(
              description,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Palette.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                onPressed();
              },
              child: Text(
                buttonText,
                style: const TextStyle(
                    color: Palette.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ));
  }
}
