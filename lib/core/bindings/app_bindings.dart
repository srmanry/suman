import 'package:get/get.dart';

import '../../feature/cart/presentation/controller/cart_controller.dart';
import '../../feature/home/data/repositories/product_repository_impl.dart';
import '../../feature/home/data/sources/product_data_source.dart';
import '../../feature/home/domain/repositories/product_repository.dart';
import '../../feature/home/domain/usecases/get_products.dart';
import '../../feature/home/presentation/controller/home_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductDataSource>(() => LocalProductDataSource());

    Get.lazyPut<ProductRepository>(
      () => ProductRepositoryImpl(Get.find<ProductDataSource>()),
    );

    Get.lazyPut<GetProductsUseCase>(
      () => GetProductsUseCase(Get.find<ProductRepository>()),
    );

    Get.put<CartController>(CartController(), permanent: true);

    Get.lazyPut<HomeController>(
      () => HomeController(
        getProductsUseCase: Get.find<GetProductsUseCase>(),
        cartController: Get.find<CartController>(),
      ),
      fenix: true,
    );
  }
}
