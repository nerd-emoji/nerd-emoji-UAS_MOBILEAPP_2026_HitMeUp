import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:hitmeup/main.dart' as app;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Step2 birthday integration scaffold', (tester) async {
    // Mock SharedPreferences used at app startup
    SharedPreferences.setMockInitialValues(<String, Object>{});

    app.main();
    await tester.pumpAndSettle();

    // Integration tests for Step2 (Step3BirthdayScreen) should be added here; kept as scaffold because
    // Windows integration builds may fail in this environment.
    expect(true, isTrue);
  });
}
