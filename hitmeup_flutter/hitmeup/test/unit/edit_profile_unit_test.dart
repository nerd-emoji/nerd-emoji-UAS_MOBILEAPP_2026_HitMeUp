import 'package:flutter_test/flutter_test.dart';
import 'package:hitmeup/screens/mainApp/editProfile.dart';
import 'dart:typed_data';

void main() {
  group('EditProfileScreen Unit Tests', () {
    // Test 1: Constructor accepts all required parameters
    test('EditProfileScreen constructor accepts all parameters', () {
      const testInterests = ['Reading', 'Gaming', 'Sports', 'Art'];
      const editProfileScreen = EditProfileScreen(
        initialName: 'John Doe',
        initialBirthday: '1995-03-15',
        initialGender: 'male',
        initialLocation: 'Jakarta',
        initialWantToMeet: 'woman',
        initialProfilePictureUrl: 'http://example.com/photo.jpg',
        initialInterests: testInterests,
      );

      expect(editProfileScreen.initialName, 'John Doe');
      expect(editProfileScreen.initialBirthday, '1995-03-15');
      expect(editProfileScreen.initialGender, 'male');
      expect(editProfileScreen.initialLocation, 'Jakarta');
      expect(editProfileScreen.initialWantToMeet, 'woman');
      expect(editProfileScreen.initialProfilePictureUrl,
          'http://example.com/photo.jpg');
      expect(editProfileScreen.initialInterests, testInterests);
      expect(editProfileScreen.testSkipInitialization, false);
    });

    // Test 2: Test hooks are optional and default to null/false
    test('EditProfileScreen test hooks are optional with correct defaults', () {
      const testInterests = ['Reading', 'Gaming'];
      const editProfileScreen = EditProfileScreen(
        initialName: 'Jane Doe',
        initialBirthday: '1998-07-22',
        initialGender: 'female',
        initialLocation: 'Bandung',
        initialWantToMeet: 'man',
        initialInterests: testInterests,
      );

      expect(editProfileScreen.testSkipInitialization, false);
      expect(editProfileScreen.testForceLocationLoading, false);
      expect(editProfileScreen.testLocationSuggestions, null);
      expect(editProfileScreen.testImagePickerResult, null);
      expect(editProfileScreen.testOnSave, null);
      expect(editProfileScreen.testOnNavigateBack, null);
    });

    // Test 3: Constructor with test hooks enabled
    test('EditProfileScreen accepts test hooks and stores them correctly', () {
      const testInterests = ['Music', 'Travel'];
      final testImageBytes = Uint8List.fromList([1, 2, 3, 4, 5]);
      final testLocationSuggestions = ['Jakarta', 'Depok', 'Bekasi'];
      bool saveCalled = false;

      final editProfileScreen = EditProfileScreen(
        initialName: 'Test User',
        initialBirthday: '2000-01-01',
        initialGender: 'male',
        initialLocation: 'Bogor',
        initialWantToMeet: 'everyone',
        initialInterests: testInterests,
        testSkipInitialization: true,
        testForceLocationLoading: true,
        testLocationSuggestions: testLocationSuggestions,
        testImagePickerResult: testImageBytes,
        testOnSave: (_) => saveCalled = true,
        testOnNavigateBack: () {},
      );

      expect(editProfileScreen.testSkipInitialization, true);
      expect(editProfileScreen.testForceLocationLoading, true);
      expect(editProfileScreen.testLocationSuggestions, testLocationSuggestions);
      expect(editProfileScreen.testImagePickerResult, testImageBytes);
      expect(editProfileScreen.testOnNavigateBack, isNotNull);
    });
  });
}
