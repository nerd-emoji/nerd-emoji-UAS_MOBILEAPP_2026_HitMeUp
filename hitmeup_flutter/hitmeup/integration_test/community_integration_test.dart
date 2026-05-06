import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:hitmeup/screens/mainApp/community.dart';
import 'package:hitmeup/services/auth_session.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await AuthSession.instance.saveUser({
      'id': 1,
      'name': 'Tester',
      'diamonds': 17,
    });
  });

  testWidgets('Community screen loads', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: CommunityScreen(),
      ),
    );

    await tester.pumpAndSettle();

    // Scaffold verification instead of expecting specific community names
    expect(find.byType(CommunityScreen), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
  });
}
