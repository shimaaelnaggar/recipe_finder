import 'package:flutter/material.dart';
import 'package:recipe_finder/core/routing/app_router.dart';
import 'package:recipe_finder/core/routing/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipe Finder',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      initialRoute: Routes.splash,
      onGenerateRoute: AppRouter().onGenerateRoute,
    );
  }
}
