import '../../domain/entities/product.dart';

class ProductModel {
  final String id;
  final String category;
  final String title;
  final String subtitle;
  final double price;
  final String imageUrl;
  final String description;

  const ProductModel({
    required this.id,
    required this.category,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.imageUrl,
    required this.description,
  });

  Product toEntity() {
    return Product(
      id: id,
      category: category,
      title: title,
      subtitle: subtitle,
      price: price,
      imageUrl: imageUrl,
      description: description,
    );
  }
}
