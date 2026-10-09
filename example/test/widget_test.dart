import 'package:flutter_test/flutter_test.dart';
import 'package:alera_example/main.dart';

void main() {
  testWidgets(
    'Example app renders correctly',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const ExampleApp(),
      );

      await tester.pumpAndSettle();

      expect(
        find.byType(ExampleApp),
        findsOneWidget,
      );
    },
  );
}