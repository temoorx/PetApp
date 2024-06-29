import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:your_app_test/src/constant/route_constants.dart';

import 'package:your_app_test/src/constant/shared_preference_constants.dart';
import 'package:your_app_test/src/di/injector.dart';
import 'package:your_app_test/src/pages/home/compoenents/evens_tab.dart';

import 'package:your_app_test/src/route/app_router.dart';
import 'package:your_app_test/src/theme/palette.dart';

import 'package:your_app_test/src/util/shared_preferences_util.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Palette.white,
        appBar: AppBar(
          title: Text('Event App',
              style: TextStyle(
                  color: Palette.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold)),
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: Palette.black,
              ),
              onPressed: () {
                getIt
                    .get<SharedPreferencesUtil>()
                    .removeValue(SharedPreferenceConstants.userId)
                    .then((value) async => await context.router.pushAndPopUntil(
                        predicate: (route) => false, const SignInRoute()));
              },
            ),
          ],
          bottom: TabBar(
            indicatorColor: Colors.black,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(
                  child: Text(
                    'Events',
                    style: TextStyle(fontSize: 16),
                  ),
                  icon: Icon(Icons.event)),
              Tab(
                  child: Text(
                    'Teams',
                    style: TextStyle(fontSize: 16),
                  ),
                  icon: Icon(Icons.group)),
              Tab(
                  icon: Icon(Icons.task),
                  child: Text(
                    'Tasks',
                    style: TextStyle(fontSize: 16),
                  ))
            ],
          ),
        ),
        body: TabBarView(
          children: [
            EventsTab(),
            Center(
                child: Text('Teams',
                    style: TextStyle(fontSize: 30, color: Palette.black))),
            Center(
                child: Text('Tasks',
                    style: TextStyle(fontSize: 30, color: Palette.black))),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Palette.black,
          onPressed: () {
            context.router.pushNamed(RouteConstants.addEventRoute);
          },
          child: Icon(Icons.add, color: Palette.white),
        ),
      ),
    );
  }
}
