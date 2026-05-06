import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  testWidgets('settings widget test', (tester) async {

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Text('Settings Screen'),
        ),
      ),
    );

    expect(find.text('Settings Screen'), findsOneWidget);
  });

}