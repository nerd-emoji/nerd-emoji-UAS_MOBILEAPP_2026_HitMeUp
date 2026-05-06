import 'package:flutter_test/flutter_test.dart';
import 'package:hitmeup/screens/signup/step6_interests_screen.dart';

void main() {
  group('Step6InterestsScreen Unit Tests', () {
    testWidgets('constructor stores all parameters correctly', (tester) async {
      final birthday = DateTime(2005, 6, 15);
      final widget = Step6InterestsScreen(
        name: 'Alice',
        email: 'alice@example.com',
        password: 'Pass1234A',
        gender: 'female',
        birthday: birthday,
        showBirthday: true,
        location: 'Jakarta',
        meetGender: 'Woman',
      );

      expect(widget.name, 'Alice');
      expect(widget.email, 'alice@example.com');
      expect(widget.password, 'Pass1234A');
      expect(widget.gender, 'female');
      expect(widget.birthday, birthday);
      expect(widget.showBirthday, true);
      expect(widget.location, 'Jakarta');
      expect(widget.meetGender, 'Woman');
      expect(widget.testOnNavigate, isNull);
    });

    testWidgets('state initializes with correct defaults', (tester) async {
      final birthday = DateTime(2005, 6, 15);
      final widget = Step6InterestsScreen(
        name: 'Bob',
        email: 'bob@example.com',
        password: 'Pass1234A',
        gender: 'male',
        birthday: birthday,
        showBirthday: false,
        location: 'Bandung',
      );

      expect(widget.name, 'Bob');
      expect(widget.meetGender, isNull);
      expect(widget.testOnNavigate, isNull);
    });

    testWidgets('testOnNavigate callback parameter can be provided', (tester) async {
      final birthday = DateTime(2005, 6, 15);
      final widget = Step6InterestsScreen(
        name: 'Charlie',
        email: 'charlie@example.com',
        password: 'Pass1234A',
        gender: 'female',
        birthday: birthday,
        showBirthday: true,
        location: 'Surabaya',
        meetGender: 'Everyone',
        testOnNavigate: (name, email, password, gender, birthday, showBirthday, location, meetGender, interests) {
          // callback provided
        },
      );

      expect(widget.testOnNavigate, isNotNull);
    });
  });
}
