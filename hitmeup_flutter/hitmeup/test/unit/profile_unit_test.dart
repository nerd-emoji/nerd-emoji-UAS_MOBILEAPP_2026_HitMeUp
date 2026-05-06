import 'package:flutter_test/flutter_test.dart';
import 'package:hitmeup/screens/mainApp/profile.dart';

void main() {
  group('ProfileScreen Unit Tests', () {
    testWidgets('constructor accepts test-only parameters', (tester) async {
      final widget = ProfileScreen(
        testSkipInitialization: true,
        testInitialDiamondBalance: 25,
        testInitialIsLoadingProfile: false,
        testInitialProfileError: 'No profile',
        testInitialName: 'Rina',
        testInitialBirthday: '1 January 2000',
        testInitialGender: 'Female',
        testInitialLocation: 'Jakarta',
        testInitialWantToMeet: 'Everyone',
        testInitialShowBirthday: true,
        testInitialProfilePictureUrl: 'media/profile.png',
        testInitialInterests: const ['Music', 'Travel'],
      );

      expect(widget.testSkipInitialization, isTrue);
      expect(widget.testInitialDiamondBalance, 25);
      expect(widget.testInitialName, 'Rina');
      expect(widget.testInitialBirthday, '1 January 2000');
      expect(widget.testInitialGender, 'Female');
      expect(widget.testInitialLocation, 'Jakarta');
      expect(widget.testInitialWantToMeet, 'Everyone');
      expect(widget.testInitialShowBirthday, true);
      expect(widget.testInitialProfilePictureUrl, 'media/profile.png');
      expect(widget.testInitialInterests, const ['Music', 'Travel']);
    });

    testWidgets('callback parameters can be provided', (tester) async {
      final widget = ProfileScreen(
        testSkipInitialization: true,
        testOnNavigateToEditProfile: () {},
        testOnNavigateToSettings: () {},
        testOnSignOutConfirmed: () {},
        testOnBottomNavTap: (index) {},
      );

      expect(widget.testOnNavigateToEditProfile, isNotNull);
      expect(widget.testOnNavigateToSettings, isNotNull);
      expect(widget.testOnSignOutConfirmed, isNotNull);
      expect(widget.testOnBottomNavTap, isNotNull);
    });

    testWidgets('default constructor leaves test hooks null', (tester) async {
      const widget = ProfileScreen();

      expect(widget.testSkipInitialization, isFalse);
      expect(widget.testOnNavigateToEditProfile, isNull);
      expect(widget.testOnNavigateToSettings, isNull);
      expect(widget.testOnSignOutConfirmed, isNull);
      expect(widget.testOnBottomNavTap, isNull);
    });
  });
}
