import 'package:flutter/material.dart';
import 'routes/app_routes.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi App Escalable',
      theme: ThemeData.light(),
      initialRoute: AppRoutes.index,
      routes: AppRoutes.getRoutes(),
    );
  }
}
