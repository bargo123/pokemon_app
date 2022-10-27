import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokedex/locator.dart';
import 'package:pokedex/routes.dart';
import 'package:pokedex/src/core/constants/routes_constants.dart';
import 'package:pokedex/src/core/utils/theme_manager.dart';

final navKey = GlobalKey<NavigatorState>();

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navKey,
      initialRoute: RouteConstants.container,
      routes: routes,
      theme: locator<ThemeManager>().appTheme(),
    );
  }
}
