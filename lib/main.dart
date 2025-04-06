import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:widget_home/core/binding/viw_model_binding.dart';
import 'package:widget_home/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialBinding: ViewModelBinding(),
      home: const HomeScreen(),
    );
  }
}
