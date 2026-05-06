import 'package:flutter_test/flutter_test.dart';

void main() {

  group('friends unit test', () {

    test('bool value true works', () {
      bool value = true;

      expect(value, true);
    });

    test('birthday string valid', () {
      String birthday = '30 September 2006';

      expect(birthday.isNotEmpty, true);
    });

    test('gender formatting valid', () {
      String gender = 'Male';

      expect(gender, 'Male');
    });

    test('interests formatting valid', () {
      List<String> interests = ['Music', 'Gaming'];

      expect(interests.isNotEmpty, true);
    });

  });

}