import 'package:flutter_test/flutter_test.dart';

import 'package:suman/feature/home/data/models/product_model.dart';

void main() {
  test('ProductModel converts to Product entity', () {
    const model = ProductModel(
      id: 'p1',
      category: 'খাবার',
      title: 'Demo',
      subtitle: 'Sub',
      price: 10,
      imageUrl: 'https://example.com/image.jpg',
      description: 'Test description',
    );

    final entity = model.toEntity();

    expect(entity.id, 'p1');
    expect(entity.category, 'খাবার');
    expect(entity.title, 'Demo');
    expect(entity.price, 10);
  });
}
