import 'package:flutter_test/flutter_test.dart';

import 'package:admin_dashboard_ui/main.dart';

void main() {
  testWidgets('Admin dashboard app renders', (WidgetTester tester) async {
    await tester.pumpWidget(const AdminDashboardApp());
    expect(find.text('Amader Store Admin Panel'), findsOneWidget);
  });
}
