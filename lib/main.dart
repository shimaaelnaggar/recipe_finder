import 'package:flutter/material.dart';
import 'package:recipe_finder/core/routing/app_router.dart';
import 'package:recipe_finder/core/routing/routes.dart';
import 'package:recipe_finder/core/services/dio_services.dart';
import 'package:recipe_finder/core/services/supabase_services.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseServices.initSupabase();
  DioServices.init();
  await Hive.initFlutter();
  await Hive.openBox('favorites');
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
