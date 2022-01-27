import 'package:flutter/material.dart';
import 'package:flutter_integration_test_demo/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_integration_test_demo/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group(
    'end-to-end test',
    () {
      testWidgets(
        "Not inputting a text and wanting to go to the display page shows "
        "an error and prevents from going to the display page.",
        (WidgetTester tester) async {
          // await tester.pumpWidget(const MyApp());
          // Build the app.
          app.main();
          await tester.pumpAndSettle();

          await tester.tap(find.byType(FloatingActionButton));
          await tester.pumpAndSettle();

          expect(find.byType(TypingPage), findsOneWidget);
          expect(find.byType(DisplayPage), findsNothing);
          expect(find.text('Input at least one character'), findsOneWidget);
        },
      );
      testWidgets(
        "After inputting a text, go to the display page which contains that same text "
        "and then navigate back to the typing page where the input should be clear",
        (WidgetTester tester) async {
          app.main();
          await tester.pumpAndSettle();

          const inputText = 'Hello Integration Test!';
          await tester.enterText(
              find.byKey(const Key('your-text-field')), inputText);

          await tester.tap(find.byType(FloatingActionButton));
          await tester.pumpAndSettle();

          expect(find.byType(TypingPage), findsNothing);
          expect(find.byType(DisplayPage), findsOneWidget);
          expect(find.text(inputText), findsOneWidget);

          await tester.tap(find.byType(BackButton));
          await tester.pumpAndSettle();

          expect(find.byType(TypingPage), findsOneWidget);
          expect(find.byType(DisplayPage), findsNothing);
          expect(find.text(inputText), findsNothing);
        },
      );
    },
  );
}
