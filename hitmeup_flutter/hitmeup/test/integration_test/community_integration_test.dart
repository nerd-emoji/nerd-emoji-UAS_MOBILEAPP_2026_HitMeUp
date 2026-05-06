import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:hitmeup/screens/mainApp/community.dart';
import 'package:hitmeup/screens/mainApp/community_chat_screen.dart';
import 'package:hitmeup/services/auth_session.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../support/community_http_mocks.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    
    // Mock audio/record platform channels to avoid MissingPluginException
    const recordChannel = MethodChannel('com.llfbandit.record/messages');
    recordChannel.setMockMethodCallHandler((call) async => null);
    
    const audioGlobalChannel = MethodChannel('xyz.luan/audioplayers.global');
    audioGlobalChannel.setMockMethodCallHandler((call) async => null);
    
    const audioCreateChannel = MethodChannel('xyz.luan/audioplayers');
    audioCreateChannel.setMockMethodCallHandler((call) async => null);
    
    ServicesBinding.instance.defaultBinaryMessenger.setMockMessageHandler(
      'xyz.luan/audioplayers.global/events',
      (message) async => null,
    );
    
    await AuthSession.instance.saveUser({
      'id': 1,
      'name': 'Tester',
      'diamonds': 17,
    });
  });

  testWidgets('Community screen loads and can join a community', (tester) async {
    CommunityHttpMocks.reset();

    await HttpOverrides.runZoned(() async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CommunityScreen(),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(CommunityScreen), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
    }, createHttpClient: (_) => CommunityHttpMocks.createHttpClient());
  });
}