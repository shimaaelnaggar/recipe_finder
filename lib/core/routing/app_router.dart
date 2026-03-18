import 'package:flutter/material.dart';
import 'package:recipe_finder/core/routing/routes.dart';
import 'package:recipe_finder/features/auth/presentation/views/login_view.dart';
import 'package:recipe_finder/features/auth/presentation/views/sign_up_view.dart';
import 'package:recipe_finder/features/layout/presentation/views/layout_bottom_nav_bar_view.dart';
import 'package:recipe_finder/features/meals/presentation/views/meals_view.dart';
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
      case Routes.layout:
        return MaterialPageRoute(builder: (_) => LayoutBottomNavBarView());
      case Routes.meals:
        final categoryName = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => MealsView(categoryName: categoryName),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
