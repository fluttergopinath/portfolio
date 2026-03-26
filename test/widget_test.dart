// This is a basic Flutter widget test.
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/main.dart';

void main() {
  testWidgets('Portfolio app loads', (WidgetTester tester) async {
    await tester.pumpWidget(const PortfolioApp());
    expect(find.text('Gopinath MJ'), findsOneWidget);
  });
}
