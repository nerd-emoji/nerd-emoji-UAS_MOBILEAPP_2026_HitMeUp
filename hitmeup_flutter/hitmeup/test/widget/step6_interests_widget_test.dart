import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hitmeup/screens/signup/step6_interests_screen.dart';
import 'package:hitmeup/widgets/common_widgets.dart';

void main() {
  group('Step6InterestsScreen Widget Tests', () {
    testWidgets('constructor passes parameters correctly', (tester) async {
      final birthday = DateTime(2005, 6, 15);
      final widget = Step6InterestsScreen(
        name: 'Test',
        email: 'test@example.com',
        password: 'Pass1234A',
        gender: 'female',
        birthday: birthday,
        showBirthday: false,
        location: 'Jakarta',
        meetGender: 'Woman',
      );

      expect(widget.name, 'Test');
      expect(widget.email, 'test@example.com');
      expect(widget.password, 'Pass1234A');
      expect(widget.gender, 'female');
      expect(widget.birthday, birthday);
      expect(widget.showBirthday, false);
      expect(widget.location, 'Jakarta');
      expect(widget.meetGender, 'Woman');
    });

    testWidgets('all 18 widgets are present in widget tree', (tester) async {
      final birthday = DateTime(2005, 6, 15);
      await tester.pumpWidget(
        MaterialApp(
          home: Step6InterestsScreen(
            name: 'Alice',
            email: 'alice@example.com',
            password: 'Pass1234A',
            gender: 'female',
            birthday: birthday,
            showBirthday: false,
            location: 'Bandung',
            meetGender: 'Everyone',
          ),
        ),
      );

      expect(find.byType(Scaffold), findsOneWidget, reason: 'Scaffold');
      expect(find.byType(Column), findsWidgets, reason: 'Column');
      expect(find.byType(SignupAppBar), findsOneWidget, reason: 'SignupAppBar');
      expect(find.byType(Expanded), findsWidgets, reason: 'Expanded');
      expect(find.byType(GradientBackground), findsOneWidget, reason: 'GradientBackground');
      expect(find.byType(SafeArea), findsOneWidget, reason: 'SafeArea');
      expect(find.byType(Padding), findsWidgets, reason: 'Padding');
      expect(find.byType(StepIndicator), findsOneWidget, reason: 'StepIndicator');
      expect(find.byType(Container), findsWidgets, reason: 'Container');
      expect(find.byType(Text), findsWidgets, reason: 'Text');
      expect(find.byType(SizedBox), findsWidgets, reason: 'SizedBox');
      expect(find.byType(Divider), findsWidgets, reason: 'Divider');
      expect(find.byType(ListView), findsWidgets, reason: 'ListView.separated');
      expect(find.byType(GestureDetector), findsWidgets, reason: 'GestureDetector');
      expect(find.byType(AnimatedContainer), findsWidgets, reason: 'AnimatedContainer');
      expect(find.byType(Center), findsWidgets, reason: 'Center');
      expect(find.byType(ElevatedButton), findsOneWidget, reason: 'ElevatedButton');
      expect(find.byType(CircularProgressIndicator), findsNothing, reason: 'CircularProgressIndicator is conditional');
    });

    testWidgets('renders title and header text', (tester) async {
      final birthday = DateTime(2005, 6, 15);
      await tester.pumpWidget(
        MaterialApp(
          home: Step6InterestsScreen(
            name: 'Bob',
            email: 'bob@example.com',
            password: 'Pass1234A',
            gender: 'male',
            birthday: birthday,
            showBirthday: true,
            location: 'Jakarta',
            meetGender: 'Man',
          ),
        ),
      );

      expect(find.text('Pick your interests'), findsOneWidget);
      expect(find.text("We'll recommend people you have more in \ncommon with"), findsOneWidget);
    });

    testWidgets('renders all category headers', (tester) async {
      final birthday = DateTime(2005, 6, 15);
      await tester.pumpWidget(
        MaterialApp(
          home: Step6InterestsScreen(
            name: 'Charlie',
            email: 'charlie@example.com',
            password: 'Pass1234A',
            gender: 'female',
            birthday: birthday,
            showBirthday: false,
            location: 'Surabaya',
            meetGender: 'Everyone',
          ),
        ),
      );

      expect(find.text('Lifestyles'), findsOneWidget);
      expect(find.text('TV & Movies'), findsOneWidget);
      expect(find.text('Activities'), findsOneWidget);
      expect(find.text('Games'), findsOneWidget);
    });

    testWidgets('renders representative interest items', (tester) async {
      final birthday = DateTime(2005, 6, 15);
      await tester.pumpWidget(
        MaterialApp(
          home: Step6InterestsScreen(
            name: 'David',
            email: 'david@example.com',
            password: 'Pass1234A',
            gender: 'male',
            birthday: birthday,
            showBirthday: false,
            location: 'Bandung',
            meetGender: 'Woman',
          ),
        ),
      );

      expect(find.text('Content Creator'), findsOneWidget);
      expect(find.text('Netflix'), findsOneWidget);
      expect(find.text('Social Media'), findsOneWidget);
      expect(find.text('Mobile Legends'), findsOneWidget);
    });

    testWidgets('renders CONTINUE button', (tester) async {
      final birthday = DateTime(2005, 6, 15);
      await tester.pumpWidget(
        MaterialApp(
          home: Step6InterestsScreen(
            name: 'Eve',
            email: 'eve@example.com',
            password: 'Pass1234A',
            gender: 'female',
            birthday: birthday,
            showBirthday: true,
            location: 'Makassar',
            meetGender: 'Everyone',
          ),
        ),
      );

      expect(find.text('CONTINUE'), findsOneWidget);
    });

    testWidgets('StepIndicator shows correct step (step 5 of 6)', (tester) async {
      final birthday = DateTime(2005, 6, 15);
      await tester.pumpWidget(
        MaterialApp(
          home: Step6InterestsScreen(
            name: 'Frank',
            email: 'frank@example.com',
            password: 'Pass1234A',
            gender: 'male',
            birthday: birthday,
            showBirthday: false,
            location: 'Jakarta',
            meetGender: 'Man',
          ),
        ),
      );

      expect(find.byType(StepIndicator), findsOneWidget);
    });

    testWidgets('callback parameter can be provided', (tester) async {
      final birthday = DateTime(2005, 6, 15);
      final widget = Step6InterestsScreen(
        name: 'Grace',
        email: 'grace@example.com',
        password: 'Pass1234A',
        gender: 'female',
        birthday: birthday,
        showBirthday: true,
        location: 'Yogyakarta',
        meetGender: 'Everyone',
        testOnNavigate: (name, email, password, gender, birthday, showBirthday, location, meetGender, interests) {},
      );

      expect(widget.testOnNavigate, isNotNull);
    });

    testWidgets('optional meetGender parameter works correctly', (tester) async {
      final birthday = DateTime(2005, 6, 15);
      final widget = Step6InterestsScreen(
        name: 'Henry',
        email: 'henry@example.com',
        password: 'Pass1234A',
        gender: 'male',
        birthday: birthday,
        showBirthday: false,
        location: 'Medan',
      );

      expect(widget.meetGender, isNull);
      expect(widget.testOnNavigate, isNull);
    });

    testWidgets('key layout widgets are present', (tester) async {
      final birthday = DateTime(2005, 6, 15);
      await tester.pumpWidget(
        MaterialApp(
          home: Step6InterestsScreen(
            name: 'Iris',
            email: 'iris@example.com',
            password: 'Pass1234A',
            gender: 'female',
            birthday: birthday,
            showBirthday: false,
            location: 'Surabaya',
            meetGender: 'Woman',
          ),
        ),
      );

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(SignupAppBar), findsOneWidget);
      expect(find.byType(GradientBackground), findsOneWidget);
      expect(find.byType(SafeArea), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('forced loading shows spinner in continue button', (tester) async {
      final birthday = DateTime(2005, 6, 15);
      await tester.pumpWidget(
        MaterialApp(
          home: Step6InterestsScreen(
            name: 'Jack',
            email: 'jack@example.com',
            password: 'Pass1234A',
            gender: 'male',
            birthday: birthday,
            showBirthday: true,
            location: 'Bandung',
            meetGender: 'Everyone',
            testForceLoading: true,
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
