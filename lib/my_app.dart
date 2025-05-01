import 'package:flutter/material.dart';
import 'package:grabai/core/routes/app_router.dart';
import 'core/theme/app_theme.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grab AI',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: AppRouter.initialRoute,
    );
  }
}
