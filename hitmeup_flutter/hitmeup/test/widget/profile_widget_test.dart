import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hitmeup/screens/mainApp/profile.dart';
import 'package:hitmeup/services/auth_session.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget _buildProfileScreen({
  bool testSkipInitialization = true,
  int? diamondBalance,
  bool? isLoadingProfile,
  String? profileError,
  String? name,
  String? birthday,
  String? gender,
  String? location,
  String? wantToMeet,
  bool? showBirthday,
  String? profilePictureUrl,
  List<String>? interests,
  VoidCallback? onEditProfile,
  VoidCallback? onSettings,
  VoidCallback? onSignOutConfirmed,
  ValueChanged<int>? onBottomNavTap,
}) {
  return MaterialApp(
    home: ProfileScreen(
      testSkipInitialization: testSkipInitialization,
      testInitialDiamondBalance: diamondBalance,
      testInitialIsLoadingProfile: isLoadingProfile,
      testInitialProfileError: profileError,
      testInitialName: name,
      testInitialBirthday: birthday,
      testInitialGender: gender,
      testInitialLocation: location,
      testInitialWantToMeet: wantToMeet,
      testInitialShowBirthday: showBirthday,
      testInitialProfilePictureUrl: profilePictureUrl,
      testInitialInterests: interests,
      testOnNavigateToEditProfile: onEditProfile,
      testOnNavigateToSettings: onSettings,
      testOnSignOutConfirmed: onSignOutConfirmed,
      testOnBottomNavTap: onBottomNavTap,
    ),
  );
}

Finder _bottomNavImageFinder(String assetName) {
  return find.byWidgetPredicate((widget) {
    return widget is Image &&
        widget.image is AssetImage &&
        (widget.image as AssetImage).assetName == assetName;
  });
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await AuthSession.instance.clear();
  });

  group('ProfileScreen Widget Tests', () {
    testWidgets('renders seeded profile layout', (tester) async {
      await tester.pumpWidget(
        _buildProfileScreen(
          diamondBalance: 42,
          isLoadingProfile: false,
          name: 'Alya',
          birthday: '12 March 2004',
          gender: 'Female',
          location: 'Bandung',
          wantToMeet: 'Everyone',
          showBirthday: true,
          interests: const ['Music', 'Gaming'],
        ),
      );

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(SafeArea), findsWidgets);
      expect(find.byType(SingleChildScrollView), findsOneWidget);
      expect(find.byType(ConstrainedBox), findsWidgets);
      expect(find.byType(Container), findsWidgets);
      expect(find.byType(Row), findsWidgets);
      expect(find.byType(Column), findsWidgets);
      expect(find.byType(Text), findsWidgets);
      expect(find.byType(OutlinedButton), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.text('Profile'), findsOneWidget);
      expect(find.text('42'), findsOneWidget);
      expect(find.text('Alya'), findsOneWidget);
      expect(find.text('12 March 2004'), findsOneWidget);
      expect(find.text('Female'), findsOneWidget);
      expect(find.text('Bandung'), findsOneWidget);
      expect(find.text('Music\nGaming'), findsOneWidget);
      expect(find.text('Everyone'), findsOneWidget);
    });

    testWidgets('shows loading indicator and error text', (tester) async {
      await tester.pumpWidget(
        _buildProfileScreen(
          diamondBalance: 17,
          isLoadingProfile: true,
          profileError: 'Unable to connect to backend.',
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Unable to connect to backend.'), findsOneWidget);
    });

    testWidgets('renders profile image fallback when no url is provided', (tester) async {
      await tester.pumpWidget(
        _buildProfileScreen(
          isLoadingProfile: false,
          profilePictureUrl: null,
        ),
      );

      expect(find.byType(ClipOval), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
      final images = tester.widgetList<Image>(find.byType(Image)).toList();
      expect(images.isNotEmpty, isTrue);
      expect(images.any((image) => image.image is AssetImage), isTrue);
    });

    testWidgets('renders network profile image when url is provided', (tester) async {
      await tester.pumpWidget(
        _buildProfileScreen(
          isLoadingProfile: false,
          profilePictureUrl: 'https://example.com/profile.png',
        ),
      );

      final images = tester.widgetList<Image>(find.byType(Image)).toList();
      expect(images.any((image) => image.image is NetworkImage), isTrue);
    });

    testWidgets('edit profile button triggers callback', (tester) async {
      var editTapped = false;
      await tester.pumpWidget(
        _buildProfileScreen(
          isLoadingProfile: false,
          onEditProfile: () {
            editTapped = true;
          },
        ),
      );

      await tester.ensureVisible(find.text('Edit profile'));
      await tester.tap(find.text('Edit profile'));
      await tester.pump();

      expect(editTapped, isTrue);
    });

    testWidgets('settings icon triggers callback', (tester) async {
      var settingsTapped = false;
      await tester.pumpWidget(
        _buildProfileScreen(
          isLoadingProfile: false,
          onSettings: () {
            settingsTapped = true;
          },
        ),
      );

      await tester.tap(find.byType(GestureDetector).first);
      await tester.pump();

      expect(settingsTapped, isTrue);
    });

    testWidgets('sign out icon opens modal bottom sheet with actions', (tester) async {
      var signOutConfirmed = false;
      await tester.pumpWidget(
        _buildProfileScreen(
          isLoadingProfile: false,
          onSignOutConfirmed: () {
            signOutConfirmed = true;
          },
        ),
      );

      await tester.ensureVisible(_bottomNavImageFinder('assets/SignOut.png'));
      await tester.tap(_bottomNavImageFinder('assets/SignOut.png'));
      await tester.pumpAndSettle();

      expect(find.text('Are you sure want to log out?'), findsOneWidget);
      expect(find.text('Log out'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);

      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      expect(find.text('Are you sure want to log out?'), findsNothing);
      expect(signOutConfirmed, isFalse);
    });

    testWidgets('sign out confirm callback is invoked', (tester) async {
      var signOutConfirmed = false;
      await tester.pumpWidget(
        _buildProfileScreen(
          isLoadingProfile: false,
          onSignOutConfirmed: () {
            signOutConfirmed = true;
          },
        ),
      );

      await tester.ensureVisible(_bottomNavImageFinder('assets/SignOut.png'));
      await tester.tap(_bottomNavImageFinder('assets/SignOut.png'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(ElevatedButton, 'Log out'));
      await tester.pumpAndSettle();

      expect(signOutConfirmed, isTrue);
    });

    testWidgets('bottom navigation taps invoke callback for target index', (tester) async {
      int? tappedIndex;
      await tester.pumpWidget(
        _buildProfileScreen(
          isLoadingProfile: false,
          onBottomNavTap: (index) {
            tappedIndex = index;
          },
        ),
      );

      await tester.tap(_bottomNavImageFinder('assets/navbar/discover.png'));
      await tester.pump();

      expect(tappedIndex, 0);
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('bottom navigation bar assets are present', (tester) async {
      await tester.pumpWidget(
        _buildProfileScreen(
          isLoadingProfile: false,
        ),
      );

      expect(_bottomNavImageFinder('assets/navbar/discover.png'), findsOneWidget);
      expect(_bottomNavImageFinder('assets/navbar/requests.png'), findsOneWidget);
      expect(_bottomNavImageFinder('assets/navbar/chat.png'), findsOneWidget);
      expect(_bottomNavImageFinder('assets/navbar/friends.png'), findsOneWidget);
      expect(_bottomNavImageFinder('assets/navbar/profileSelected.png'), findsOneWidget);
    });
  });
}
