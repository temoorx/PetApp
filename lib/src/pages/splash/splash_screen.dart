import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:your_app_test/src/constant/assets_constants.dart';
import 'package:your_app_test/src/constant/shared_preference_constants.dart';
import 'package:your_app_test/src/di/injector.dart';
import 'package:your_app_test/src/route/app_router.dart';
import 'package:your_app_test/src/theme/theme.dart';
import 'package:your_app_test/src/util/shared_preferences_util.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  MyTheme? theme;

  @override
  void initState() {
    _navigateAfterDelay();
    super.initState();
  }

  void _navigateAfterDelay() {
    Timer(const Duration(seconds: 1), () async {
      await getIt
          .get<SharedPreferencesUtil>()
          .getString(SharedPreferenceConstants.userId)
          .then((value) async => value == null
              ? await context.router.pushAndPopUntil(
                  predicate: (route) => false, const SignInRoute())
              : await context.router.pushAndPopUntil(
                  predicate: (route) => false, const HomeRoute()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyTheme>(
      builder: (context, theme, child) {
        this.theme = theme;
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AssetsConstants.backgroundImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Image.asset(
                AssetsConstants.newSplashLogo,
                width: 200,
                height: 200,
              ),
            ),
          ],
        );
      },
    );
  }
}
