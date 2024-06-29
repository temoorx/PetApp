import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:your_app_test/src/theme/palette.dart';
import 'package:your_app_test/src/pages/sign_up/components/sign_up_form.dart';

@RoutePage()
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_back_ios, color: Palette.black),
                    Text(
                      'Back',
                      style: TextStyle(
                        color: Palette.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Hello there 👋",
                    style: const TextStyle(
                      color: Palette.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Create an account to get started",
                    style: const TextStyle(
                      color: Palette.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const SignUpForm(),
            ],
          ),
        ),
      ),
    );
  }
}
