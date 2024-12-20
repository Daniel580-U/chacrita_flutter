
import 'package:chacrita/splash_screen.dart';
import 'package:chacrita/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:chacrita/provider.dart';

//import 'package:chacrita/lib/componente.dart';
void main() async {
  await dotenv.load(fileName: 'assets/.env');
  runApp(
    ChangeNotifierProvider(
      create: (_) => GlobalState(),
      child: const MyApp(),
    ),);
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
      //home: const IndexPage(),
      home: const SplashScreen(),
    );
  }
}