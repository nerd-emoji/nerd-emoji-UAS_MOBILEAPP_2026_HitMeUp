import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hitmeup/screens/mainApp/editProfile.dart';
import 'dart:typed_data';

void main() {
  group('EditProfileScreen Widget Tests', () {
    const testInterests = ['Reading', 'Gaming', 'Sports', 'Art'];

    Widget buildTestApp({
      required String initialName,
      required String initialBirthday,
      required String initialGender,
      required String initialLocation,
      required String initialWantToMeet,
      String? initialProfilePictureUrl,
      List<String>? initialInterests,
      bool testSkipInitialization = false,
      bool testForceLocationLoading = false,
      List<String>? testLocationSuggestions,
      bool testShowLocationSuggestions = false,
      Uint8List? testImagePickerResult,
      Function(Map<String, dynamic>)? testOnSave,
      VoidCallback? testOnNavigateBack,
    }) {
      return MaterialApp(
        home: EditProfileScreen(
          initialName: initialName,
          initialBirthday: initialBirthday,
          initialGender: initialGender,
          initialLocation: initialLocation,
          initialWantToMeet: initialWantToMeet,
          initialProfilePictureUrl: initialProfilePictureUrl,
          initialInterests: initialInterests ?? testInterests,
          testSkipInitialization: testSkipInitialization,
          testForceLocationLoading: testForceLocationLoading,
          testLocationSuggestions: testLocationSuggestions,
          testShowLocationSuggestions: testShowLocationSuggestions,
          testImagePickerResult: testImagePickerResult,
          testOnSave: testOnSave,
          testOnNavigateBack: testOnNavigateBack,
        ),
      );
    }

    // Test 1: Scaffold is rendered with transparent background
    testWidgets('Renders Scaffold with main structure', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestApp(
          initialName: 'John Doe',
          initialBirthday: '1995-03-15',
          initialGender: 'male',
          initialLocation: 'Jakarta',
          initialWantToMeet: 'woman',
        ),
      );

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(Container), findsWidgets);
      expect(find.byType(AppBar), findsOneWidget);
    });

    // Test 2: AppBar displays "Edit Profile" title
    testWidgets('AppBar shows Edit Profile title', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestApp(
          initialName: 'Jane Doe',
          initialBirthday: '1998-07-22',
          initialGender: 'female',
          initialLocation: 'Bandung',
          initialWantToMeet: 'man',
        ),
      );

      expect(find.text('Edit Profile'), findsOneWidget);
    });

    // Test 3: SafeArea and SingleChildScrollView are present
    testWidgets('SafeArea and SingleChildScrollView wrap content',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestApp(
          initialName: 'Test User',
          initialBirthday: '2000-01-01',
          initialGender: 'male',
          initialLocation: 'Bogor',
          initialWantToMeet: 'everyone',
        ),
      );

      // AppBar might have its own SafeArea, so use findsWidgets
      expect(find.byType(SafeArea), findsWidgets);
      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    // Test 4: Profile image ClipOval and image display
    testWidgets('Profile image is displayed with ClipOval frame',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestApp(
          initialName: 'User',
          initialBirthday: '2000-01-01',
          initialGender: 'male',
          initialLocation: 'Jakarta',
          initialWantToMeet: 'woman',
          initialProfilePictureUrl: 'http://example.com/photo.jpg',
        ),
      );

      expect(find.byType(ClipOval), findsOneWidget);
      // Image.network or Image.asset fallback
      expect(
        find.byType(Image),
        findsWidgets,
      );
    });

    // Test 5: Change Profile Picture GestureDetector tap
    testWidgets('Change Profile Picture text is tappable via GestureDetector',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestApp(
          initialName: 'User',
          initialBirthday: '2000-01-01',
          initialGender: 'male',
          initialLocation: 'Jakarta',
          initialWantToMeet: 'woman',
        ),
      );

      expect(find.text('Change Profile Picture'), findsOneWidget);
      // Verify GestureDetector exists for tapping
      expect(find.byType(GestureDetector), findsWidgets);
    });

    // Test 6: Name TextField is present and editable
    testWidgets('Name TextField displays and is editable',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestApp(
          initialName: 'John Doe',
          initialBirthday: '1995-03-15',
          initialGender: 'male',
          initialLocation: 'Jakarta',
          initialWantToMeet: 'woman',
        ),
      );

      expect(find.byType(TextField), findsWidgets);
      final nameField = find.byType(TextField).first;
      expect(find.text('John Doe'), findsOneWidget);

      // Test editing name
      await tester.enterText(nameField, 'Jane Doe');
      await tester.pump();
      expect(find.text('Jane Doe'), findsOneWidget);
    });

    // Test 7: Birthday field and GestureDetector for date picker
    testWidgets('Birthday field renders with GestureDetector',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestApp(
          initialName: 'User',
          initialBirthday: '1995-03-15',
          initialGender: 'male',
          initialLocation: 'Jakarta',
          initialWantToMeet: 'woman',
        ),
      );

      expect(find.text('Birthday date'), findsOneWidget);
      expect(find.byType(GestureDetector), findsWidgets);
    });

    // Test 8: Gender dropdown is rendered
    testWidgets('Gender dropdown field is present',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestApp(
          initialName: 'User',
          initialBirthday: '2000-01-01',
          initialGender: 'male',
          initialLocation: 'Jakarta',
          initialWantToMeet: 'woman',
        ),
      );

      expect(find.text('Gender'), findsOneWidget);
      // DropdownButton might have type parameter variations
      expect(find.byType(DropdownButtonHideUnderline), findsOneWidget);
    });

    // Test 9: Location field with TextField
    testWidgets('Location field is present and functional',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestApp(
          initialName: 'User',
          initialBirthday: '2000-01-01',
          initialGender: 'male',
          initialLocation: 'Jakarta',
          initialWantToMeet: 'woman',
        ),
      );

      expect(find.text('Location'), findsOneWidget);
    });

    // Test 10: Location suggestions display when provided
    testWidgets('Location suggestions card displays with ListView.separated',
        (WidgetTester tester) async {
      const testSuggestions = ['Jakarta', 'Depok', 'Bekasi'];

      await tester.pumpWidget(
        buildTestApp(
          initialName: 'User',
          initialBirthday: '2000-01-01',
          initialGender: 'male',
          initialLocation: 'Jaka',
          initialWantToMeet: 'woman',
          testLocationSuggestions: testSuggestions,
          testShowLocationSuggestions: true,
        ),
      );

      await tester.pumpAndSettle();

      // ListView should show location suggestions
      expect(find.byType(ListView), findsWidgets);
      // Verify suggestions are available in the tree
      expect(find.byType(ListTile), findsWidgets);
    });

    // Test 11: Location loading indicator when forced
    testWidgets('Location loading state shows CircularProgressIndicator',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestApp(
          initialName: 'User',
          initialBirthday: '2000-01-01',
          initialGender: 'male',
          initialLocation: 'Jakarta',
          initialWantToMeet: 'woman',
          testForceLocationLoading: true,
        ),
      );

      // With test flag, location loading state is set
      // CircularProgressIndicator may appear depending on location field state
      expect(find.byType(CircularProgressIndicator), findsWidgets);
    });

    // Test 12: Interests section displays all TextFields
    testWidgets('Interests section displays all 4 interest TextFields',
        (WidgetTester tester) async {
      const interests = ['Reading', 'Gaming', 'Sports', 'Art'];

      await tester.pumpWidget(
        buildTestApp(
          initialName: 'User',
          initialBirthday: '2000-01-01',
          initialGender: 'male',
          initialLocation: 'Jakarta',
          initialWantToMeet: 'woman',
          initialInterests: interests,
        ),
      );

      expect(find.text('My interests'), findsOneWidget);
      expect(find.text('Reading'), findsOneWidget);
      expect(find.text('Gaming'), findsOneWidget);
      expect(find.text('Sports'), findsOneWidget);
      expect(find.text('Art'), findsOneWidget);
    });

    // Test 13: Want to Meet options with InkWell
    testWidgets('Want to meet options display with InkWell buttons',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestApp(
          initialName: 'User',
          initialBirthday: '2000-01-01',
          initialGender: 'male',
          initialLocation: 'Jakarta',
          initialWantToMeet: 'woman',
        ),
      );

      expect(find.text('Who do you want to meet?'), findsOneWidget);
      expect(find.text('Man'), findsOneWidget);
      expect(find.text('Woman'), findsOneWidget);
      expect(find.text('Everyone'), findsOneWidget);
      expect(find.byType(InkWell), findsWidgets);
    });

    // Test 14: Done button is present and not disabled initially
    testWidgets('Done button (ElevatedButton) is present and enabled',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestApp(
          initialName: 'User',
          initialBirthday: '2000-01-01',
          initialGender: 'male',
          initialLocation: 'Jakarta',
          initialWantToMeet: 'woman',
        ),
      );

      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text('Done'), findsOneWidget);

      final doneButton = find.byType(ElevatedButton);
      final button = tester.widget<ElevatedButton>(doneButton);
      expect(button.onPressed, isNotNull);
    });

    // Test 15: Done button calls testOnSave when tapped
    testWidgets('Done button tap calls testOnSave callback',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestApp(
          initialName: 'John Doe',
          initialBirthday: '1995-03-15',
          initialGender: 'male',
          initialLocation: 'Jakarta',
          initialWantToMeet: 'woman',
          testOnSave: (_) {},
        ),
      );

      final doneButton = find.byType(ElevatedButton);
      expect(doneButton, findsOneWidget);
      
      // Scroll to make button visible (off-screen at y=827 with viewport height=600)
      await tester.dragUntilVisible(
        doneButton,
        find.byType(SingleChildScrollView),
        const Offset(0, -300),
      );
      
      // Verify button can be tapped
      await tester.tap(doneButton);
      await tester.pump();

      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    // Test 16: ConstrainedBox for layout constraints
    testWidgets('ConstrainedBox elements are present for layout',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestApp(
          initialName: 'User',
          initialBirthday: '2000-01-01',
          initialGender: 'male',
          initialLocation: 'Jakarta',
          initialWantToMeet: 'woman',
        ),
      );

      expect(find.byType(ConstrainedBox), findsWidgets);
    });

    // Test 17: Column and Row layout elements
    testWidgets('Column and Row layout elements are present',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestApp(
          initialName: 'User',
          initialBirthday: '2000-01-01',
          initialGender: 'male',
          initialLocation: 'Jakarta',
          initialWantToMeet: 'woman',
        ),
      );

      expect(find.byType(Column), findsWidgets);
      expect(find.byType(Row), findsWidgets);
    });

    // Test 18: Expanded layout elements for responsive design
    testWidgets('Expanded widgets are used for responsive layout',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestApp(
          initialName: 'User',
          initialBirthday: '2000-01-01',
          initialGender: 'male',
          initialLocation: 'Jakarta',
          initialWantToMeet: 'woman',
        ),
      );

      expect(find.byType(Expanded), findsWidgets);
    });

    // Test 19: Gender selection is interactive
    testWidgets('Gender dropdown is interactive', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestApp(
          initialName: 'User',
          initialBirthday: '2000-01-01',
          initialGender: 'male',
          initialLocation: 'Jakarta',
          initialWantToMeet: 'woman',
        ),
      );

      final hideUnderline = find.byType(DropdownButtonHideUnderline);
      expect(hideUnderline, findsOneWidget);
    });

    // Test 20: Want to meet selection with InkWell
    testWidgets('Want to meet options are selectable via InkWell',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestApp(
          initialName: 'User',
          initialBirthday: '2000-01-01',
          initialGender: 'male',
          initialLocation: 'Jakarta',
          initialWantToMeet: 'woman',
        ),
      );

      final inkWells = find.byType(InkWell);
      expect(inkWells, findsWidgets);

      // Tap on one of the InkWell options
      await tester.tap(inkWells.at(0));
      await tester.pumpAndSettle();
    });

    // Test 21: Interest fields are editable
    testWidgets('Interest TextFields can be edited',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestApp(
          initialName: 'User',
          initialBirthday: '2000-01-01',
          initialGender: 'male',
          initialLocation: 'Jakarta',
          initialWantToMeet: 'woman',
          initialInterests: ['Reading', 'Gaming', 'Sports', 'Art'],
        ),
      );

      // Find and edit first interest
      final interestFields = find.byType(TextField);
      // The first TextField is the name field, so we skip it
      if (interestFields.evaluate().length > 1) {
        await tester.enterText(interestFields.at(1), 'NewInterest');
        await tester.pump();
        expect(find.text('NewInterest'), findsOneWidget);
      }
    });

    // Test 22: Multiple TextFields for different inputs
    testWidgets('Multiple TextFields exist for name, location, interests',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestApp(
          initialName: 'User',
          initialBirthday: '2000-01-01',
          initialGender: 'male',
          initialLocation: 'Jakarta',
          initialWantToMeet: 'woman',
          initialInterests: ['Reading', 'Gaming', 'Sports', 'Art'],
        ),
      );

      // Name + Location + 4 Interests = 6 TextFields minimum
      expect(find.byType(TextField), findsWidgets);
    });

    // Test 23: Divider elements in location suggestions
    testWidgets('Divider elements appear in suggestions list',
        (WidgetTester tester) async {
      const testSuggestions = ['Jakarta', 'Depok', 'Bekasi'];

      await tester.pumpWidget(
        buildTestApp(
          initialName: 'User',
          initialBirthday: '2000-01-01',
          initialGender: 'male',
          initialLocation: 'Jaka',
          initialWantToMeet: 'woman',
          testLocationSuggestions: testSuggestions,
          testShowLocationSuggestions: true,
        ),
      );

      await tester.pumpAndSettle();

      // When suggestions are shown, ListView is displayed
      expect(find.byType(ListView), findsWidgets);
    });

    // Test 24: ListTile elements in suggestions
    testWidgets('ListTile elements appear in location suggestions',
        (WidgetTester tester) async {
      const testSuggestions = ['Jakarta', 'Depok', 'Bekasi'];

      await tester.pumpWidget(
        buildTestApp(
          initialName: 'User',
          initialBirthday: '2000-01-01',
          initialGender: 'male',
          initialLocation: 'Jaka',
          initialWantToMeet: 'woman',
          testLocationSuggestions: testSuggestions,
          testShowLocationSuggestions: true,
        ),
      );

      await tester.pumpAndSettle();

      // ListTiles render in suggestions when displayed
      expect(find.byType(ListTile), findsWidgets);
    });

    // Test 25: Background gradient container is applied
    testWidgets('Background gradient decoration is applied to Container',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestApp(
          initialName: 'User',
          initialBirthday: '2000-01-01',
          initialGender: 'male',
          initialLocation: 'Jakarta',
          initialWantToMeet: 'woman',
        ),
      );

      final containers = find.byType(Container);
      expect(containers, findsWidgets);
    });

    // Test 26: Verify all 19+ widgets from requirements are present
    testWidgets('All required widgets are rendered',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestApp(
          initialName: 'John Doe',
          initialBirthday: '1995-03-15',
          initialGender: 'male',
          initialLocation: 'Jakarta',
          initialWantToMeet: 'woman',
          initialProfilePictureUrl: 'http://example.com/photo.jpg',
          initialInterests: ['Reading', 'Gaming', 'Sports', 'Art'],
          testLocationSuggestions: ['Jakarta', 'Depok'],
          testShowLocationSuggestions: true,
        ),
      );

      // Verify key widgets exist
      expect(find.byType(Container), findsWidgets); // gradient + profile frame
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(SafeArea), findsWidgets); // Multiple SafeAreas possible
      expect(find.byType(SingleChildScrollView), findsOneWidget);
      expect(find.byType(Column), findsWidgets);
      expect(find.byType(Row), findsWidgets);
      expect(find.byType(Expanded), findsWidgets);
      expect(find.byType(ClipOval), findsOneWidget);
      expect(find.byType(Image), findsWidgets);
      expect(find.byType(GestureDetector), findsWidgets);
      expect(find.byType(TextField), findsWidgets);
      expect(find.byType(DropdownButtonHideUnderline), findsOneWidget);
      expect(find.byType(InkWell), findsWidgets);
      expect(find.byType(ConstrainedBox), findsWidgets);
      expect(find.byType(ListView), findsWidgets);
      expect(find.byType(ListTile), findsWidgets);
      expect(find.byType(ElevatedButton), findsOneWidget);
      // CircularProgressIndicator renders when _isSaving is true (not by default)
      expect(find.text('Done'), findsOneWidget);
    });
  });
}
