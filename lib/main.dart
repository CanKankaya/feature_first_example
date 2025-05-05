import 'package:feature_first_example/core/app/bindings.dart';
import 'package:feature_first_example/core/app/routes.dart';
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
      title: 'Feature First Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialBinding: AppBindings(),
      initialRoute: AppRoutes.posts,
      getPages: AppRoutes.pages,
      debugShowCheckedModeBanner: false,
    );
  }
}
