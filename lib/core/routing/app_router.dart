import 'package:flutter/material.dart';
import 'package:recipe_finder/core/routing/routes.dart';
import 'package:recipe_finder/features/auth/presentation/views/login_view.dart';
import 'package:recipe_finder/features/auth/presentation/views/sign_up_view.dart';
import 'package:recipe_finder/features/splash/views/splash_view.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => SplashView());
      case Routes.login:
      return MaterialPageRoute(builder: (_) => LoginView());
      case Routes.signUp:
      return MaterialPageRoute(builder: (_) => SignUpView());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
