import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../cart/presentation/controller/cart_controller.dart';
import '../controller/home_controller.dart';
import '../widgets/product_card.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('আমার মুদি দোকান'),
        actions: [
          Obx(
            () => Stack(
              children: [
                IconButton(
                  onPressed: () => Get.toNamed(AppRoutes.cart),
                  icon: const Icon(Icons.shopping_bag_outlined),
                ),
                if (cartController.itemCount > 0)
                  Positioned(
                    right: 10,
                    top: 8,
                    child: Container(
                      width: 18,
                      height: 18,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE11D48),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${cartController.itemCount}',
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0B8F6A), Color(0xFF33B98E)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'আজকের অফার',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'দৈনন্দিন প্রয়োজনীয় সব ক্যাটাগরিতে বিশেষ ছাড়',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'পণ্য খুঁজুন',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: Icon(Icons.tune, color: Colors.grey.shade500),
                ),
              ),
              const SizedBox(height: 12),
              Obx(
                () => SizedBox(
                  height: 36,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: HomeController.categories
                        .map(
                          (category) => _CategoryChip(
                            label: category,
                            active:
                                controller.selectedCategory.value == category,
                            onTap: () => controller.changeCategory(category),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'জনপ্রিয় পণ্য',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.errorMessage.value != null) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(controller.errorMessage.value!),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: controller.loadProducts,
                            child: const Text('আবার চেষ্টা করুন'),
                          ),
                        ],
                      ),
                    );
                  }

                  if (controller.products.isEmpty) {
                    return const Center(
                      child: Text('এই ক্যাটাগরিতে কোনো পণ্য নেই'),
                    );
                  }

                  return GridView.builder(
                    itemCount: controller.products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.67,
                        ),
                    itemBuilder: (context, index) {
                      final product = controller.products[index];
                      return ProductCard(
                        product: product,
                        onTap: () => controller.openProductDetail(product),
                        onAddToCart: () => controller.addToCart(product),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            color: active ? const Color(0xFF0B8F6A) : Colors.white,
            border: Border.all(
              color: active ? const Color(0xFF0B8F6A) : Colors.grey.shade300,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: active ? Colors.white : const Color(0xFF374151),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
