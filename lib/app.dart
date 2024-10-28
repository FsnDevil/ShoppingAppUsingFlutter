import 'package:flutter/material.dart';
import 'package:shopping_app_flutter/screens/home_screen.dart';

class WeatherApp extends MaterialApp{

  const WeatherApp({super.key}) : super(home: const HomeScreen());

  @override
  bool get debugShowCheckedModeBanner => false;

  @override
  ThemeData? get theme => ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
          useMaterial3: true,
          inputDecorationTheme: const InputDecorationTheme(
              hintStyle:  TextStyle(
                fontFamily: "suse",
                fontWeight: FontWeight.bold,
              )
          )
  );

  @override
  String get title => "Shopping App..";


}