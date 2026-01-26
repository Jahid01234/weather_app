import 'package:flutter/material.dart';
import 'package:weather_app/screens/splash_screen.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white24,
          foregroundColor: Colors.white
        ),
      ),
      home: const SplashScreen(),
    );
  }
}