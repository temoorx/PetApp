import 'package:auto_route/auto_route.dart';
import 'package:your_app_test/src/constant/route_constants.dart';
import 'package:your_app_test/src/pages/home/home_screen.dart';
import 'package:your_app_test/src/pages/sign_in/sign_in_screen.dart';
import 'package:your_app_test/src/pages/sign_up/sign_up_screen.dart';
import 'package:your_app_test/src/pages/splash/splash_screen.dart';
import 'package:your_app_test/src/pages/home/compoenents/add_events.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: SplashRoute.page,
          initial: true,
          path: '/',
        ),
        AutoRoute(
          page: SignInRoute.page,
          path: RouteConstants.signInRoute,
        ),
        AutoRoute(
          page: HomeRoute.page,
          path: RouteConstants.homeRoute,
        ),
        AutoRoute(
          page: SignUpRoute.page,
          path: RouteConstants.signUpRoute,
        ),
        AutoRoute(page: AddEventRoute.page, path: RouteConstants.addEventRoute)
      ];
}
