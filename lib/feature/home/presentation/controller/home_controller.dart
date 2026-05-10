import 'package:get/get.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../cart/presentation/controller/cart_controller.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/get_products.dart';

class HomeController extends GetxController {
  final GetProductsUseCase getProductsUseCase;
  final CartController cartController;

  HomeController({
    required this.getProductsUseCase,
    required this.cartController,
  });

  final products = <Product>[].obs;
  final isLoading = false.obs;
  final errorMessage = RxnString();
  final selectedCategory = 'সব'.obs;

  final List<Product> _allProducts = <Product>[];

  static const foodGroup = '🥦 খাদ্যদ্রব্য (Food)';

  static const categories = [
    'সব',
    foodGroup,
    '🍚 চাল ও আটা',
    '🧂 মসলা',
    '🛢️ তেল ও ঘি',
    '🍪 স্ন্যাকস',
    '🥤 পানীয়',
    '🧼 ব্যক্তিগত যত্ন (Personal Care)',
    '🧹 পরিষ্কার-পরিচ্ছন্নতা (Cleaning)',
    '👶 বেবি প্রোডাক্ট',
    '🏠 গৃহস্থালি জিনিস (Home Essentials)',
  ];

  @override
  void onInit() {
    super.onInit();
    loadProducts();
  }

  Future<void> loadProducts() async {
    isLoading.value = true;
    errorMessage.value = null;

    try {
      _allProducts
        ..clear()
        ..addAll(await getProductsUseCase());
      _applyFilter();
    } catch (_) {
      errorMessage.value = 'পণ্য লোড করা যায়নি। আবার চেষ্টা করুন।';
    } finally {
      isLoading.value = false;
    }
  }

  void changeCategory(String category) {
    selectedCategory.value = category;
    _applyFilter();
  }

  void _applyFilter() {
    if (selectedCategory.value == 'সব') {
      products.assignAll(_allProducts);
      return;
    }

    if (selectedCategory.value == foodGroup) {
      const foodSubCategories = [
        '🍚 চাল ও আটা',
        '🧂 মসলা',
        '🛢️ তেল ও ঘি',
        '🍪 স্ন্যাকস',
        '🥤 পানীয়',
      ];

      products.assignAll(
        _allProducts.where(
          (product) => foodSubCategories.contains(product.category),
        ),
      );
      return;
    }

    products.assignAll(
      _allProducts.where(
        (product) => product.category == selectedCategory.value,
      ),
    );
  }

  void addToCart(Product product) {
    cartController.add(product);
  }

  void openProductDetail(Product product) {
    Get.toNamed(AppRoutes.productDetail, arguments: product);
  }
}
