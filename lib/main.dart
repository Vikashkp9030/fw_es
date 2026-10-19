import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/bindings/initial_binding.dart';
import 'app/core/app_theme.dart';
import 'app/routes/app_pages.dart';

void main() {
  runApp(const FencingWorldApp());
}

class FencingWorldApp extends StatelessWidget {
  const FencingWorldApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Fencing World & Energy Solutions',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      initialBinding: InitialBinding(),
      initialRoute: '/',
      getPages: AppPages.pages,
    );
  }
}
