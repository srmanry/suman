import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../sources/product_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductDataSource dataSource;

  const ProductRepositoryImpl(this.dataSource);

  @override
  Future<List<Product>> getProducts() async {
    final models = await dataSource.fetchProducts();
    return models.map((model) => model.toEntity()).toList();
  }
}
