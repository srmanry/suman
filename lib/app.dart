import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/bindings/app_bindings.dart';
import 'core/routes/app_pages.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';

class ECommerceApp extends StatelessWidget {
  const ECommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'আমার মুদি দোকান',
      theme: AppTheme.light,
      initialRoute: AppRoutes.home,
      initialBinding: AppBindings(),
      getPages: AppPages.routes,
    );
  }
}
