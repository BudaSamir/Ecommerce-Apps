import 'package:eco_x/utilities/routes.dart';
import 'package:eco_x/views/screens/landing_screen.dart';
import 'package:eco_x/views/screens/auth_screen.dart';
import 'package:flutter/cupertino.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case AppRoutes.landingScreenRoute:
      case AppRoutes.loginScreenRoute:
        return CupertinoPageRoute(builder: (_) => const AuthScreen());

      default:
        return CupertinoPageRoute(builder: (_) => const LandingScreen());
    }
  }
}
