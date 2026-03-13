import 'package:flutter/material.dart';
import 'package:recipe_finder/core/routing/routes.dart';
import 'package:recipe_finder/features/splash/views/splash_view.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => SplashView());
      case Routes.login:
      // return MaterialPageRoute(builder: (_) => LoginView());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
