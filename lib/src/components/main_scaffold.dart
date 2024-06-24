import 'package:flutter/material.dart';
import 'package:your_app_test/src/theme/get_theme_color.dart';
import 'package:your_app_test/src/theme/palette.dart';

class MainScaffold extends StatelessWidget {
  final bool? isGradient;
  final Widget? appBar;
  final Widget? bottomNavigationBar;
  final double? preferredSizeAppBar;
  final Widget? floatingActionButton;

  const MainScaffold({
    super.key,
    required this.body,
    this.isGradient,
    this.appBar,
    this.bottomNavigationBar,
    this.preferredSizeAppBar = kToolbarHeight * 1.4,
    this.floatingActionButton,
  });

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      fit: StackFit.expand,
      children: [
        isGradient == true
            ? Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Color(0XFF101113).withOpacity(0),
                  Color(0XFF101113)
                ])),
              )
            : Container(
                decoration: BoxDecoration(color: getThemeColor(context)),
              ),
        Scaffold(
          floatingActionButton: floatingActionButton,
          bottomNavigationBar: bottomNavigationBar,
          appBar: appBar != null
              ? PreferredSize(
                  preferredSize: Size.fromHeight(
                      preferredSizeAppBar ?? kToolbarHeight + 1),
                  child: appBar!)
              : null,
          body: body,
        ),
      ],
    );
  }
}
