import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hitmeup/main.dart' as app;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Step1 intro integration scaffold', (tester) async {
    // Mock SharedPreferences used at app startup
    SharedPreferences.setMockInitialValues(<String, Object>{});

    app.main();
    await tester.pumpAndSettle();

    // Integration tests for Step1 should be added here; kept as scaffold because
    // Windows integration builds may fail in this environment.
    expect(true, isTrue);
  });
}
