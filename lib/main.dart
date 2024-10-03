import 'package:flickflow/views/main_view/main_view.dart';
import 'package:flickflow/views/splash_view/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  runApp(SplashView(
    key: UniqueKey(),
    onInitializationComplete: () => runApp(ProviderScope(child: MyApp())),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlickFlow',
      initialRoute: 'home',
      routes: {'home': (BuildContext _context) => MainView()},
      theme: ThemeData(
          useMaterial3: true,
          primaryColor: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
    );
  }
}
