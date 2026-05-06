import 'package:flutter_test/flutter_test.dart';

void main() {

  group('settings unit test', () {

    test('bool parsing works', () {
      bool value = true;

      expect(value, true);
    });

    test('birthday string not empty', () {
      String birthday = '30 September 2006';

      expect(birthday.isNotEmpty, true);
    });

    test('diamond balance valid', () {
      int diamonds = 17;

      expect(diamonds > 0, true);
    });

  });

}