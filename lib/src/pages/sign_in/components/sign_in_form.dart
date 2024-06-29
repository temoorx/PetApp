import 'package:auto_route/auto_route.dart';
import 'package:control_style/control_style.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_app_test/src/components/text_field_component.dart';
import 'package:your_app_test/src/pages/sign_in/components/primary_button.dart';
import 'package:your_app_test/src/theme/palette.dart';
import 'package:your_app_test/src/constant/route_constants.dart';
import 'package:your_app_test/src/constant/shared_preference_constants.dart';
import 'package:your_app_test/src/constant/string_constants.dart';
import 'package:your_app_test/src/constant/toast_component.dart';
import 'package:your_app_test/src/di/injector.dart';
import 'package:your_app_test/src/pages/sign_in/cubit/sign_in_button_validation_cubit.dart';

import 'package:your_app_test/src/pages/sign_in/cubit/sign_in_cubit.dart';
import 'package:your_app_test/src/route/app_router.dart';
import 'package:your_app_test/src/util/shared_preferences_util.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    BlocProvider.of<SignInButtonValidationCubit>(context).checkIsValidate();
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Column(
        children: [
          const SizedBox(height: 25),
          TextFormFieldComponent(
              onChanged: (value) {
                BlocProvider.of<SignInButtonValidationCubit>(context)
                    .checkIsValidate();
              },
              hintText: "Enter Email",
              controller: BlocProvider.of<SignInCubit>(context).emailController,
              textInputType: TextInputType.emailAddress),
          const SizedBox(height: 5),
          TextFormFieldComponent(
              onChanged: (value) {
                BlocProvider.of<SignInButtonValidationCubit>(context)
                    .checkIsValidate();
              },
              textInputType: TextInputType.visiblePassword,
              hintText: "Enter Password",
              isPassword: true,
              controller:
                  BlocProvider.of<SignInCubit>(context).passwordController),
          const SizedBox(height: 15),
          SignInButton(formKey: formKey),
          const SizedBox(height: 50),
          RegisterHereTextButton()
        ],
      ),
    );
  }
}

class SignInButton extends StatelessWidget {
  const SignInButton({
    super.key,
    required this.formKey,
  });

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInCubit, SignInState>(
        listener: (context, state) => state.maybeWhen(orElse: () {
              return null;
            }, error: (message) async {
              ToastComponent3(context).showToast(context, message);
              return null;
            }, loaded: (id) async {
              await getIt
                  .get<SharedPreferencesUtil>()
                  .setString(
                      SharedPreferenceConstants.userId, id.user!.uid.toString())
                  .then((value) => context.router.pushAndPopUntil(
                      predicate: (route) => false, const HomeRoute()));
              return null;
            }),
        builder: (context, state) => state.maybeWhen(
            loading: () => PrimaryButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Palette.white),
                    ),
                    const SizedBox(width: 10),
                    Text("Loading...",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Palette.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700))
                  ],
                ),
                onPressed: () {}),
            loaded: (token) => SignUpButtonVadationState(
                formKey: formKey, title: StringConstants.login),
            error: (message) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SignUpButtonVadationState(
                        formKey: formKey, title: StringConstants.login),
                    const SizedBox(height: 10),
                    Text(message,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Palette.redIndicatorColor))
                  ]);
            },
            orElse: () => SignUpButtonVadationState(
                formKey: formKey, title: StringConstants.login)));
  }
}

class RegisterHereTextButton extends StatelessWidget {
  const RegisterHereTextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          context.router.pushNamed(RouteConstants.signUpRoute);
        },
        child: RichText(
            text: TextSpan(
                text: 'Don’t have an account? ',
                style: TextStyle(
                    color: Palette.black.withOpacity(0.5),
                    fontWeight: FontWeight.w500,
                    fontSize: 13),
                children: [
              TextSpan(
                text: 'Register here',
                style: TextStyle(
                  height: 1.5,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w500,
                  color: Palette.black,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    context.router.pushNamed(RouteConstants.signUpRoute);
                  },
              ),
            ])));
  }
}

class SignUpButtonVadationState extends StatelessWidget {
  const SignUpButtonVadationState({
    super.key,
    required this.formKey,
    required this.title,
  });

  final String title;

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInButtonValidationCubit,
        SignInButtonValidationState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => Container(),
          enabled: () {
            return PrimaryButton(
              child: Text(title,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Palette.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      )),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  context.read<SignInCubit>().signIn();
                }
              },
            );
          },
          disabled: () {
            return PrimaryButton(
              child: Text(title,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Palette.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      )),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  context.read<SignInCubit>().signIn();
                }
              },
            );
          },
        );
      },
    );
  }
}
