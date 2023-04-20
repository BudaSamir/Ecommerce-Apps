import 'package:eco_x/utilities/routes.dart';
import 'package:eco_x/views/screens/bottom_nav_bar.dart';
import 'package:eco_x/views/screens/landing_screen.dart';
import 'package:eco_x/views/screens/auth_screen.dart';
import 'package:flutter/cupertino.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case AppRoutes.loginScreenRoute:
        return CupertinoPageRoute(
            builder: (_) => const AuthScreen(), settings: routeSettings);

      case AppRoutes.bottomNavBarRoute:
        return CupertinoPageRoute(
            builder: (_) => const BottomNavBar(), settings: routeSettings);
      case AppRoutes.landingScreenRoute:
      default:
        return CupertinoPageRoute(
            builder: (_) => const LandingScreen(), settings: routeSettings);
    }
  }
}
