import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  testWidgets('friends widget test', (tester) async {

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Text('Friends Screen'),
        ),
      ),
    );

    expect(find.text('Friends Screen'), findsOneWidget);
  });

}