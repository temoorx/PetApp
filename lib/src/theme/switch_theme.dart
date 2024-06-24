import 'package:provider/provider.dart';
import 'package:your_app_test/main.dart';
import 'package:your_app_test/src/theme/theme.dart';

void switchThemeApp() =>
    Provider.of<MyTheme>(navigationService!.navigatorKey.currentContext!,
            listen: false)
        .switchTheme();
