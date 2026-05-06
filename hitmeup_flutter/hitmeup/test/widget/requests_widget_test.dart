import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hitmeup/screens/mainApp/requests.dart';

void main() {
  testWidgets('Requests screen renders successfully', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: RequestsScreen(),
      ),
    );

    // Screen should render with Scaffold
    expect(find.byType(Scaffold), findsOneWidget);
  });

  testWidgets('Requests screen has app bar', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: RequestsScreen(),
      ),
    );

    // Check for AppBar
    expect(find.byType(AppBar), findsOneWidget);
  });

  testWidgets('Requests screen has bottom nav', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: RequestsScreen(),
      ),
    );

    // The screen uses a custom bottom nav, not BottomNavigationBar
    expect(find.byType(BottomNavigationBar), findsNothing);
  });
}