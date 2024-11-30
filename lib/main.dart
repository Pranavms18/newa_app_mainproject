import 'package:flutter/material.dart';
import 'package:newa_app_mainproject/controller/home_screen_controller.dart';
import 'package:newa_app_mainproject/view/home_screen/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NewsScreenController(),
        )
      ],
      child: MaterialApp(
        home: Homescreen(),
      ),
    );
  }
}
