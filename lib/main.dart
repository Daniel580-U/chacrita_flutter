
import 'package:chacrita/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:chacrita/features/index/pages/index_page.dart';

//import 'package:chacrita/lib/componente.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chacrita',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: AppRoutes.getRoutes(),
      home: const IndexPage(),
    );
  }
}