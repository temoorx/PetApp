import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_app_test/src/components/text_field_component.dart';
import 'package:your_app_test/src/theme/palette.dart';
import 'package:your_app_test/src/constant/route_constants.dart';
import 'package:your_app_test/src/constant/string_constants.dart';
import 'package:your_app_test/src/constant/toast_component.dart';
import 'package:your_app_test/src/pages/verify_email/cubit/verify_email_cubit.dart';

class VerifyEmailBody extends StatelessWidget {
  const VerifyEmailBody({super.key, required this.email});
  final String email;
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    TextEditingController email = TextEditingController();
    return BlocConsumer<VerifyEmailCubit, VerifyEmailState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () => Container(),
          error: (message) =>
              ToastComponent3(context).showToast(context, message),
          loaded: (message) {
            ToastComponent2(context).showToast(context, message);
            context.maybePop();
          },
        );
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              TextFormFieldComponent(
                  onChanged: (value) {},
                  textInputType: TextInputType.emailAddress,
                  controller: email,
                  hintText: 'Enter Your Email'),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      await BlocProvider.of<VerifyEmailCubit>(context)
                          .verifyEmail(email: email.text);
                    }

                    // context.router.push(const OTPRoute());
                  },
                  child: Text(
                    StringConstants.sendCode,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Palette.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                  )),
              const SizedBox(height: 40),
              _rememberPassword(context),
            ],
          ),
        );
      },
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
}
