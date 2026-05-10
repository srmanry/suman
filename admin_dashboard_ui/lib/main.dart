import 'package:flutter/material.dart';

void main() {
  runApp(const AdminDashboardApp());
}

class AdminDashboardApp extends StatelessWidget {
  const AdminDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Amader Store Admin',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF4F7FB),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0F766E)),
      ),
      home: const DashboardPage(),
    );
  }
}

enum AdminSection { dashboard, products, orders, campaigns, customers }

class ProductItem {
  final String id;
  final String name;
  final String category;
  final double price;
  int stock;

  ProductItem({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.stock,
  });
}

class OrderItem {
  final String id;
  final String customer;
  final int itemsCount;
  final double amount;
  final String paymentMethod;
  final DateTime createdAt;
  String status;

  OrderItem({
    required this.id,
    required this.customer,
    required this.itemsCount,
    required this.amount,
    required this.paymentMethod,
    required this.createdAt,
    required this.status,
  });
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  AdminSection section = AdminSection.dashboard;

  final products = <ProductItem>[
    ProductItem(
      id: 'P-101',
      name: 'মিনিকেট চাল (১ কেজি)',
      category: '🍚 চাল ও আটা',
      price: 85,
      stock: 36,
    ),
    ProductItem(
      id: 'P-102',
      name: 'আটা (২ কেজি)',
      category: '🍚 চাল ও আটা',
      price: 140,
      stock: 11,
    ),
    ProductItem(
      id: 'P-103',
      name: 'সয়াবিন তেল (১ লিটার)',
      category: '🛢️ তেল ও ঘি',
      price: 195,
      stock: 8,
    ),
    ProductItem(
      id: 'P-104',
      name: 'বিস্কুট (৩০০ গ্রাম)',
      category: '🍪 স্ন্যাকস',
      price: 75,
      stock: 22,
    ),
  ];

  final orders = <OrderItem>[
    OrderItem(
      id: 'ORD-5511',
      customer: 'মোঃ আলী',
      itemsCount: 3,
      amount: 950,
      paymentMethod: 'ক্যাশ অন ডেলিভারি',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      status: 'Pending',
    ),
    OrderItem(
      id: 'ORD-5512',
      customer: 'রিমা আক্তার',
      itemsCount: 2,
      amount: 560,
      paymentMethod: 'bKash',
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
      status: 'Confirmed',
    ),
    OrderItem(
      id: 'ORD-5513',
      customer: 'শাওন',
      itemsCount: 5,
      amount: 1430,
      paymentMethod: 'Nagad',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      status: 'Delivered',
    ),
  ];

  final activities = <String>[
    'New order ORD-5511 placed',
    'Stock alert on সয়াবিন তেল',
    'Weekend campaign updated',
  ];

  String productQuery = '';

  int get pendingOrders =>
      orders.where((order) => order.status == 'Pending').length;
  int get lowStockCount =>
      products.where((product) => product.stock <= 10).length;
  double get todaySales => orders
      .where((order) => order.status == 'Delivered')
      .fold<double>(0, (sum, order) => sum + order.amount);

  List<ProductItem> get filteredProducts {
    if (productQuery.trim().isEmpty) {
      return products;
    }

    final q = productQuery.toLowerCase();
    return products
        .where(
          (product) =>
              product.name.toLowerCase().contains(q) ||
              product.category.toLowerCase().contains(q),
        )
        .toList();
  }

  void _openAddProductDialog() {
    final nameController = TextEditingController();
    final categoryController = TextEditingController();
    final priceController = TextEditingController();
    final stockController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('নতুন প্রোডাক্ট যোগ করুন'),
          content: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'প্রোডাক্ট নাম',
                    ),
                    validator: (v) =>
                        v == null || v.trim().isEmpty ? 'নাম দিন' : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: categoryController,
                    decoration: const InputDecoration(labelText: 'ক্যাটাগরি'),
                    validator: (v) =>
                        v == null || v.trim().isEmpty ? 'ক্যাটাগরি দিন' : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'দাম'),
                    validator: (v) => v == null || double.tryParse(v) == null
                        ? 'সঠিক দাম দিন'
                        : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: stockController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'স্টক'),
                    validator: (v) => v == null || int.tryParse(v) == null
                        ? 'সঠিক স্টক দিন'
                        : null,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('বাতিল'),
            ),
            ElevatedButton(
              onPressed: () {
                if (!formKey.currentState!.validate()) {
                  return;
                }

                setState(() {
                  final id = 'P-${100 + products.length + 1}';
                  products.add(
                    ProductItem(
                      id: id,
                      name: nameController.text.trim(),
                      category: categoryController.text.trim(),
                      price: double.parse(priceController.text.trim()),
                      stock: int.parse(stockController.text.trim()),
                    ),
                  );
                  activities.insert(
                    0,
                    'New product added: ${nameController.text.trim()}',
                  );
                });

                Navigator.of(context).pop();
              },
              child: const Text('যোগ করুন'),
            ),
          ],
        );
      },
    );
  }

  void _confirmOrder(OrderItem order) {
    setState(() {
      order.status = 'Confirmed';
      activities.insert(0, 'Order ${order.id} confirmed');
    });
  }

  void _updateOrderStatus(OrderItem order, String status) {
    setState(() {
      order.status = status;
      activities.insert(0, 'Order ${order.id} moved to $status');
    });
  }

  void _incrementStock(ProductItem product) {
    setState(() {
      product.stock += 1;
    });
  }

  void _decrementStock(ProductItem product) {
    if (product.stock == 0) {
      return;
    }
    setState(() {
      product.stock -= 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 980;

        return Scaffold(
          drawer: isDesktop
              ? null
              : Drawer(
                  child: SafeArea(
                    child: _Sidebar(
                      current: section,
                      onChanged: (value) {
                        setState(() => section = value);
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
          appBar: AppBar(
            title: const Text('Amader Store Admin Panel'),
            actions: [
              if (section == AdminSection.products)
                TextButton.icon(
                  onPressed: _openAddProductDialog,
                  icon: const Icon(Icons.add),
                  label: const Text('New Product'),
                ),
              const SizedBox(width: 8),
              const Padding(
                padding: EdgeInsets.only(right: 16),
                child: CircleAvatar(child: Icon(Icons.person)),
              ),
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: isDesktop
                  ? Row(
                      children: [
                        SizedBox(
                          width: 250,
                          child: _Sidebar(
                            current: section,
                            onChanged: (value) =>
                                setState(() => section = value),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(child: _buildSectionContent(isDesktop: true)),
                      ],
                    )
                  : _buildSectionContent(isDesktop: false),
            ),
          ),
          floatingActionButton: section == AdminSection.products
              ? FloatingActionButton.extended(
                  onPressed: _openAddProductDialog,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Product'),
                )
              : null,
        );
      },
    );
  }

  Widget _buildSectionContent({required bool isDesktop}) {
    return switch (section) {
      AdminSection.dashboard => _DashboardHome(
        isDesktop: isDesktop,
        todaySales: todaySales,
        totalProducts: products.length,
        totalOrders: orders.length,
        pendingOrders: pendingOrders,
        lowStockCount: lowStockCount,
        activities: activities,
        orders: orders,
        onConfirmOrder: _confirmOrder,
      ),
      AdminSection.products => _ProductsSection(
        products: filteredProducts,
        query: productQuery,
        onQueryChanged: (value) => setState(() => productQuery = value),
        onIncrementStock: _incrementStock,
        onDecrementStock: _decrementStock,
      ),
      AdminSection.orders => _OrdersSection(
        orders: orders,
        onConfirmOrder: _confirmOrder,
        onUpdateStatus: _updateOrderStatus,
      ),
      AdminSection.campaigns => const _SimplePanel(
        title: 'Campaign Management',
        subtitle:
            'Flash sale, coupon, banner, seasonal offer এখানে configure করা যাবে।',
      ),
      AdminSection.customers => const _SimplePanel(
        title: 'Customer Management',
        subtitle:
            'Customer list, order history, support ticket এখানে manage করা যাবে।',
      ),
    };
  }
}

class _Sidebar extends StatelessWidget {
  final AdminSection current;
  final ValueChanged<AdminSection> onChanged;

  const _Sidebar({required this.current, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF083344), Color(0xFF115E59)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Control Room',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 18),
            _NavItem(
              icon: Icons.dashboard_outlined,
              label: 'Dashboard',
              active: current == AdminSection.dashboard,
              onTap: () => onChanged(AdminSection.dashboard),
            ),
            _NavItem(
              icon: Icons.inventory_2_outlined,
              label: 'Products',
              active: current == AdminSection.products,
              onTap: () => onChanged(AdminSection.products),
            ),
            _NavItem(
              icon: Icons.receipt_long_outlined,
              label: 'Orders',
              active: current == AdminSection.orders,
              onTap: () => onChanged(AdminSection.orders),
            ),
            _NavItem(
              icon: Icons.campaign_outlined,
              label: 'Campaigns',
              active: current == AdminSection.campaigns,
              onTap: () => onChanged(AdminSection.campaigns),
            ),
            _NavItem(
              icon: Icons.people_alt_outlined,
              label: 'Customers',
              active: current == AdminSection.customers,
              onTap: () => onChanged(AdminSection.customers),
            ),
            const Spacer(),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Operational UI\nProduct & Order focused',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: active ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: ListTile(
            dense: true,
            leading: Icon(
              icon,
              color: active ? const Color(0xFF115E59) : Colors.white,
            ),
            title: Text(
              label,
              style: TextStyle(
                color: active ? const Color(0xFF115E59) : Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DashboardHome extends StatelessWidget {
  final bool isDesktop;
  final double todaySales;
  final int totalProducts;
  final int totalOrders;
  final int pendingOrders;
  final int lowStockCount;
  final List<String> activities;
  final List<OrderItem> orders;
  final ValueChanged<OrderItem> onConfirmOrder;

  const _DashboardHome({
    required this.isDesktop,
    required this.todaySales,
    required this.totalProducts,
    required this.totalOrders,
    required this.pendingOrders,
    required this.lowStockCount,
    required this.activities,
    required this.orders,
    required this.onConfirmOrder,
  });

  @override
  Widget build(BuildContext context) {
    final cards = [
      (
        'আজকের বিক্রি',
        '৳${todaySales.toStringAsFixed(0)}',
        Icons.payments_outlined,
      ),
      ('মোট প্রোডাক্ট', '$totalProducts', Icons.inventory_2_outlined),
      ('মোট অর্ডার', '$totalOrders', Icons.receipt_long_outlined),
      ('Pending Order', '$pendingOrders', Icons.pending_actions_outlined),
      ('Low Stock', '$lowStockCount', Icons.warning_amber_outlined),
    ];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF0F766E), Color(0xFF0E7490)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Text(
              'Store Operations Center\nTrack orders, update products, and run your shop smoothly.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w700,
                height: 1.35,
              ),
            ),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cards.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isDesktop ? 5 : 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: isDesktop ? 1.6 : 1.4,
            ),
            itemBuilder: (context, index) {
              final item = cards[index];
              return _KpiCard(title: item.$1, value: item.$2, icon: item.$3);
            },
          ),
          const SizedBox(height: 12),
          isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _QuickOrdersCard(
                        orders: orders,
                        onConfirmOrder: onConfirmOrder,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(child: _ActivityCard(activities: activities)),
                  ],
                )
              : Column(
                  children: [
                    _QuickOrdersCard(
                      orders: orders,
                      onConfirmOrder: onConfirmOrder,
                    ),
                    const SizedBox(height: 10),
                    _ActivityCard(activities: activities),
                  ],
                ),
        ],
      ),
    );
  }
}

class _KpiCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _KpiCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF0F766E)),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: const TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickOrdersCard extends StatelessWidget {
  final List<OrderItem> orders;
  final ValueChanged<OrderItem> onConfirmOrder;

  const _QuickOrdersCard({required this.orders, required this.onConfirmOrder});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order Confirmation Queue',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          ...orders
              .take(5)
              .map(
                (order) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${order.id} - ${order.customer} (${order.status})',
                        ),
                      ),
                      if (order.status == 'Pending')
                        ElevatedButton(
                          onPressed: () => onConfirmOrder(order),
                          child: const Text('Confirm'),
                        )
                      else
                        const Icon(
                          Icons.check_circle,
                          color: Color(0xFF16A34A),
                        ),
                    ],
                  ),
                ),
              ),
        ],
      ),
    );
  }
}

class _ActivityCard extends StatelessWidget {
  final List<String> activities;

  const _ActivityCard({required this.activities});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Live Activity',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          ...activities
              .take(6)
              .map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.bolt,
                        size: 16,
                        color: Color(0xFF0F766E),
                      ),
                      const SizedBox(width: 8),
                      Expanded(child: Text(item)),
                    ],
                  ),
                ),
              ),
        ],
      ),
    );
  }
}

class _ProductsSection extends StatelessWidget {
  final List<ProductItem> products;
  final String query;
  final ValueChanged<String> onQueryChanged;
  final ValueChanged<ProductItem> onIncrementStock;
  final ValueChanged<ProductItem> onDecrementStock;

  const _ProductsSection({
    required this.products,
    required this.query,
    required this.onQueryChanged,
    required this.onIncrementStock,
    required this.onDecrementStock,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Product Management',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          TextField(
            onChanged: onQueryChanged,
            decoration: InputDecoration(
              hintText: 'Search by name/category',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: query.isEmpty
                  ? null
                  : IconButton(
                      onPressed: () => onQueryChanged(''),
                      icon: const Icon(Icons.close),
                    ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: products.isEmpty
                ? const Center(child: Text('No product found'))
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('ID')),
                        DataColumn(label: Text('Name')),
                        DataColumn(label: Text('Category')),
                        DataColumn(label: Text('Price')),
                        DataColumn(label: Text('Stock')),
                        DataColumn(label: Text('Action')),
                      ],
                      rows: products
                          .map(
                            (product) => DataRow(
                              cells: [
                                DataCell(Text(product.id)),
                                DataCell(Text(product.name)),
                                DataCell(Text(product.category)),
                                DataCell(
                                  Text('৳${product.price.toStringAsFixed(0)}'),
                                ),
                                DataCell(
                                  Text(
                                    '${product.stock}',
                                    style: TextStyle(
                                      color: product.stock <= 10
                                          ? Colors.red
                                          : Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () =>
                                            onDecrementStock(product),
                                        icon: const Icon(
                                          Icons.remove_circle_outline,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () =>
                                            onIncrementStock(product),
                                        icon: const Icon(
                                          Icons.add_circle_outline,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _OrdersSection extends StatelessWidget {
  final List<OrderItem> orders;
  final ValueChanged<OrderItem> onConfirmOrder;
  final void Function(OrderItem order, String status) onUpdateStatus;

  const _OrdersSection({
    required this.orders,
    required this.onConfirmOrder,
    required this.onUpdateStatus,
  });

  @override
  Widget build(BuildContext context) {
    const statuses = [
      'Pending',
      'Confirmed',
      'Packed',
      'Shipped',
      'Delivered',
      'Cancelled',
    ];

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order Management',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.separated(
              itemCount: orders.length,
              separatorBuilder: (_, _) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final order = orders[index];
                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${order.id} • ${order.customer}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Text('৳${order.amount.toStringAsFixed(0)}'),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Items: ${order.itemsCount} • Payment: ${order.paymentMethod}',
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              initialValue: order.status,
                              decoration: const InputDecoration(
                                labelText: 'Status',
                              ),
                              items: statuses
                                  .map(
                                    (status) => DropdownMenuItem(
                                      value: status,
                                      child: Text(status),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                if (value == null) {
                                  return;
                                }
                                onUpdateStatus(order, value);
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          if (order.status == 'Pending')
                            ElevatedButton.icon(
                              onPressed: () => onConfirmOrder(order),
                              icon: const Icon(Icons.check),
                              label: const Text('Confirm'),
                            ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SimplePanel extends StatelessWidget {
  final String title;
  final String subtitle;

  const _SimplePanel({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Text(subtitle),
        ],
      ),
    );
  }
}
