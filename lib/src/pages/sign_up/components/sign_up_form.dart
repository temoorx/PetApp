import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_app_test/src/components/app_loader.dart';
import 'package:your_app_test/src/components/text_field_component.dart';
import 'package:your_app_test/src/pages/sign_in/components/primary_button.dart';
import 'package:your_app_test/src/theme/palette.dart';
import 'package:your_app_test/src/constant/string_constants.dart';
import 'package:your_app_test/src/constant/toast_component.dart';
import 'package:your_app_test/src/pages/sign_up/components/already_account.dart';
import 'package:your_app_test/src/pages/sign_up/cubit/sign_up_cubit.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.always,
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 40),
          TextFormFieldComponent(
            onChanged: (value) {},
            borderRadius: 12,
            controller: _emailController,
            hintText: 'Enter Email',
            isLabel: true,
            label: 'Username / Email',
            textInputType: TextInputType.emailAddress,
          ),
          SizedBox(height: 20),
          TextFormFieldComponent(
            onChanged: (value) {},
            borderRadius: 12,
            controller: _passwordController,
            isLabel: true,
            label: 'Password',
            hintText: 'Password',
            isPassword: true,
            textInputType: TextInputType.visiblePassword,
          ),
          SizedBox(height: 20),
          TextFormFieldComponent(
            onChanged: (value) {},
            borderRadius: 12,
            controller: _confirmPasswordController,
            isLabel: true,
            label: 'Confirm Password',
            hintText: 'Confirm Password',
            isPassword: true,
            textInputType: TextInputType.visiblePassword,
          ),
          const SizedBox(height: 20),
          BlocConsumer<SignUpCubit, SignUpState>(
            builder: (context, state) => state.maybeWhen(
              orElse: () => Stack(
                alignment: Alignment.center,
                children: [
                  PrimaryButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (_confirmPasswordController.text ==
                              _passwordController.text) {
                            context.read<SignUpCubit>().signUp(
                                  userName: _firstNameController.text,
                                  password: _passwordController.text,
                                  email: _emailController.text,
                                  confirmPassword:
                                      _confirmPasswordController.text,
                                );
                          } else {
                            ToastComponent3(context)
                                .showToast(context, 'Password not match');
                          }
                        }
                      },
                      child: Text(
                        StringConstants.signUp,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Palette.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                      )),
                  Text(
                    StringConstants.signUp,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Palette.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                  )
                ],
              ),
              loading: () => Stack(
                alignment: Alignment.center,
                children: [
                  PrimaryButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Loading...',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: Palette.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  )),
                          const SizedBox(width: 10),
                          const SizedBox(
                            height: 20,
                            width: 20,
                            child: AppProgressIndicator(
                              color: Palette.white,
                            ),
                          )
                        ],
                      )),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Loading...',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Palette.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  )),
                      const SizedBox(width: 10),
                      const SizedBox(
                        height: 20,
                        width: 20,
                        child: AppProgressIndicator(
                          color: Palette.white,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              error: (message) => Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      PrimaryButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (_confirmPasswordController.text ==
                                  _passwordController.text) {
                                context.read<SignUpCubit>().signUp(
                                      userName: _firstNameController.text,
                                      password: _passwordController.text,
                                      email: _emailController.text,
                                      confirmPassword:
                                          _confirmPasswordController.text,
                                    );
                              } else {
                                ToastComponent3(context)
                                    .showToast(context, 'Password not match');
                              }
                            }
                          },
                          child: Text(
                            StringConstants.signUp,
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: Palette.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                          )),
                      Text(
                        StringConstants.signUp,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Palette.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    message,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Palette.redIndicatorColor),
                  ),
                ],
              ),
            ),
            listener: (context, state) => state.maybeWhen(orElse: () {
              return null;
            }, error: (message) {
              ToastComponent3(context).showToast(context, message);
              return null;
            }, initial: () {
              return null;
            }, loaded: (response) {
              ToastComponent2(context)
                  .showToast(context, 'Account created successfully');
              return Navigator.pop(context);
            }),
          ),
          const SizedBox(height: 20),
          const Align(alignment: Alignment.center, child: AlreadyAccount()),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
