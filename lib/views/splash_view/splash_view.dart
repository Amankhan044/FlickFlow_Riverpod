import 'dart:convert';

import 'package:flickflow/data/models/config.dart';
import 'package:flickflow/services/http_services.dart';
import 'package:flickflow/services/movie_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

class SplashView extends StatefulWidget {
  final VoidCallback onInitializationComplete;
  const SplashView({required Key key, required this.onInitializationComplete})
      : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 5)).then((_) => _setup(context).then(
          (_) => widget.onInitializationComplete(),
        ));
  }

  Future<void> _setup(BuildContext context) async {
    final getIt = GetIt.instance;
    final configFile = await rootBundle.loadString("assets/config/main.json");
    final configData = jsonDecode(configFile);
    getIt.registerSingleton<AppConfig>(AppConfig(
      apiKey: configData['API_KEY'],
      baseApiUrl: configData['BASE_API_URL'],
      baseImageApiUrl: configData['BASE_IMAGE_API_URL'],
    ));

    getIt.registerSingleton<HTTPService>(HTTPService());
    getIt.registerSingleton<MovieService>(MovieService());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlickFlow',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Center(
        child: Container(
          height: 200,
          width: 200,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/logo.png"),
                  fit: BoxFit.contain)),
        ),
      ),
    );
    ;
  }
}
