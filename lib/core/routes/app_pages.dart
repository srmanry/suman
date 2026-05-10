import 'package:get/get.dart';

import '../../feature/cart/presentation/view/cart_page.dart';
import '../../feature/home/presentation/view/home_page.dart';
import '../../feature/home/presentation/view/product_detail_page.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = <GetPage<dynamic>>[
    GetPage(name: AppRoutes.home, page: () => const HomePage()),
    GetPage(
      name: AppRoutes.productDetail,
      page: () => const ProductDetailPage(),
    ),
    GetPage(name: AppRoutes.cart, page: () => const CartPage()),
  ];
}
