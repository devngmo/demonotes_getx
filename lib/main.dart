import 'package:demonotes_getx/app/app_pages.dart';
import 'package:demonotes_getx/app/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Demo Notes',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      getPages: AppPages,
      initialRoute: AppRoutes.Home,
      debugShowCheckedModeBanner: false,
    );
  }
}
