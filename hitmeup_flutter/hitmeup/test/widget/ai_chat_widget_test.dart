import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hitmeup/screens/mainApp/ai_chat_screen.dart';
import 'package:hitmeup/services/auth_session.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget _buildScreen({
  int? contextUserId,
  int? contextCommunityId,
  String? contextTitle,
  bool testSkipInitialization = true,
  bool? testInitialIsLoading,
  bool? testInitialIsInitializingChat,
  List<Map<String, dynamic>>? testInitialMessages,
  Map<int, Map<String, dynamic>>? testInitialRecommendedProfiles,
  String? testInitialMainUserProfileUrl,
  int? testInitialAiChatId,
  bool? testInitialHasMoreOlderMessages,
  String? testInitialPlayingVoiceUrl,
  bool? testInitialIsVoicePlaying,
  void Function(String text)? testOnSendMessage,
  void Function(String rawVoiceUrl)? testOnVoicePlayback,
  void Function(int receiverId)? testOnFriendRequest,
  Future<void> Function()? testOnLoadOlderMessages,
}) {
  return MaterialApp(
    home: AiChatScreen(
      contextUserId: contextUserId,
      contextCommunityId: contextCommunityId,
      contextTitle: contextTitle,
      testSkipInitialization: testSkipInitialization,
      testInitialIsLoading: testInitialIsLoading,
      testInitialIsInitializingChat: testInitialIsInitializingChat,
      testInitialMessages: testInitialMessages,
      testInitialRecommendedProfiles: testInitialRecommendedProfiles,
      testInitialMainUserProfileUrl: testInitialMainUserProfileUrl,
      testInitialAiChatId: testInitialAiChatId,
      testInitialHasMoreOlderMessages: testInitialHasMoreOlderMessages,
      testInitialPlayingVoiceUrl: testInitialPlayingVoiceUrl,
      testInitialIsVoicePlaying: testInitialIsVoicePlaying,
      testOnSendMessage: testOnSendMessage,
      testOnVoicePlayback: testOnVoicePlayback,
      testOnFriendRequest: testOnFriendRequest,
      testOnLoadOlderMessages: testOnLoadOlderMessages,
    ),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await AuthSession.instance.clear();
  });

  group('AiChatScreen Widget Tests', () {
    testWidgets('shows loading state with progress indicator', (tester) async {
      await tester.pumpWidget(
        _buildScreen(
          testInitialIsLoading: true,
          testInitialIsInitializingChat: true,
        ),
      );

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(Container), findsWidgets);
      expect(find.byType(Stack), findsWidgets);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('renders app bar and input bar in idle state', (tester) async {
      await tester.pumpWidget(
        _buildScreen(
          testInitialIsLoading: false,
          testInitialIsInitializingChat: false,
          testInitialMessages: const [],
        ),
      );

      expect(find.byType(IconButton), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byIcon(Icons.arrow_upward), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(Expanded), findsWidgets);
      expect(find.byType(Positioned), findsWidgets);
    });

    testWidgets('shows default AI chat title', (tester) async {
      await tester.pumpWidget(
        _buildScreen(
          testInitialIsLoading: false,
          testInitialIsInitializingChat: false,
        ),
      );

      expect(find.text('Chat.AI'), findsOneWidget);
      expect(find.byType(Image), findsWidgets);
      expect(find.byType(CircleAvatar), findsOneWidget);
    });

    testWidgets('shows contextual chat title for friend context', (tester) async {
      await tester.pumpWidget(
        _buildScreen(
          contextUserId: 42,
          contextTitle: 'Nadia',
          testInitialIsLoading: false,
          testInitialIsInitializingChat: false,
        ),
      );

      expect(find.text('Kembali ke chat dengan "Nadia"'), findsOneWidget);
    });

    testWidgets('shows contextual chat title for community context', (tester) async {
      await tester.pumpWidget(
        _buildScreen(
          contextCommunityId: 77,
          contextTitle: 'Flutter Club',
          testInitialIsLoading: false,
          testInitialIsInitializingChat: false,
        ),
      );

      expect(find.text('Kembali ke chat di "Flutter Club"'), findsOneWidget);
    });

    testWidgets('typing indicator renders from assistant placeholder', (tester) async {
      await tester.pumpWidget(
        _buildScreen(
          testInitialIsLoading: false,
          testInitialIsInitializingChat: false,
          testInitialMessages: const [
            {
              'id': 'typing-1',
              'text': '',
              'image': null,
              'voiceRecording': null,
              'isMe': false,
              'isFromAI': true,
              'recommendedUserIds': <int>[],
              'time': '',
              '_localType': '__assistant_typing__',
            },
          ],
        ),
      );

      expect(find.byType(AnimatedBuilder), findsWidgets);
      expect(find.byType(Transform), findsWidgets);
    });

    testWidgets('message bubble renders image and voice controls', (tester) async {
      await tester.pumpWidget(
        _buildScreen(
          testInitialIsLoading: false,
          testInitialIsInitializingChat: false,
          testInitialMessages: const [
            {
              'id': 1,
              'sender': 1,
              'isFromAI': false,
              'text': 'Here is an attachment',
              'image': 'media/test-image.png',
              'voiceRecording': 'media/test-voice.mp3',
              'time': '10:00',
            },
          ],
        ),
      );

      expect(find.byType(ClipRRect), findsWidgets);
      expect(find.byType(Image), findsWidgets);
      expect(find.byType(GestureDetector), findsWidgets);
    });

    testWidgets('send button invokes test callback and clears text', (tester) async {
      String? sentText;
      await tester.pumpWidget(
        _buildScreen(
          testInitialIsLoading: false,
          testInitialIsInitializingChat: false,
          testOnSendMessage: (text) {
            sentText = text;
          },
        ),
      );

      await tester.enterText(find.byType(TextField), 'Hello AI');
      await tester.tap(find.byIcon(Icons.arrow_upward));
      await tester.pump();

      expect(sentText, 'Hello AI');
      expect(find.text('Hello AI'), findsNothing);
    });

    testWidgets('shows snackbar when not logged in and send is tapped', (tester) async {
      await tester.pumpWidget(
        _buildScreen(
          testInitialIsLoading: false,
          testInitialIsInitializingChat: false,
          testInitialAiChatId: 1,
        ),
      );

      await tester.enterText(find.byType(TextField), 'Hello AI');
      await tester.tap(find.byIcon(Icons.arrow_upward));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));

      expect(find.text('Not logged in or AI chat unavailable'), findsOneWidget);
    });

    testWidgets('voice playback tap invokes test callback', (tester) async {
      String? playedUrl;
      await tester.pumpWidget(
        _buildScreen(
          testInitialIsLoading: false,
          testInitialIsInitializingChat: false,
          testInitialMessages: const [
            {
              'id': 2,
              'sender': 1,
              'isFromAI': false,
              'text': 'voice',
              'voiceRecording': 'media/voice.mp3',
              'time': '10:01',
            },
          ],
          testOnVoicePlayback: (url) {
            playedUrl = url;
          },
        ),
      );

      await tester.tap(find.byIcon(Icons.play_circle_fill_rounded));
      await tester.pump();

      expect(playedUrl, 'media/voice.mp3');
    });

    testWidgets('recommended profile card renders and friend request button works', (tester) async {
      int? requestedId;
      await tester.pumpWidget(
        _buildScreen(
          testInitialIsLoading: false,
          testInitialIsInitializingChat: false,
          testInitialMessages: const [
            {
              'id': 3,
              'sender': 2,
              'isFromAI': true,
              'text': 'Try this [FRIEND_REC]7[/FRIEND_REC]',
              'image': null,
              'voiceRecording': null,
              'time': '10:02',
            },
          ],
          testInitialRecommendedProfiles: {
            7: {
              'id': 7,
              'name': 'Mira',
              'location': 'Bandung',
              'level': 4,
              'profilepicture': 'media/profile.png',
            },
          },
          testOnFriendRequest: (receiverId) {
            requestedId = receiverId;
          },
        ),
      );

      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text('TAMBAH'), findsOneWidget);
      await tester.tap(find.text('TAMBAH'));
      await tester.pump();

      expect(requestedId, 7);
      expect(find.byType(Image), findsWidgets);
    });

    testWidgets('scrolling near top triggers older messages callback', (tester) async {
      var loadOlderCalls = 0;
      final messages = List.generate(30, (index) {
        return {
          'id': index + 1,
          'sender': index % 2 == 0 ? 1 : 2,
          'isFromAI': index % 2 == 1,
          'text': 'Message ${index + 1}',
          'image': null,
          'voiceRecording': null,
          'time': '10:${index.toString().padLeft(2, '0')}',
        };
      });

      await tester.pumpWidget(
        _buildScreen(
          testInitialIsLoading: false,
          testInitialIsInitializingChat: false,
          testInitialAiChatId: 99,
          testInitialMessages: messages,
          testInitialHasMoreOlderMessages: true,
          testOnLoadOlderMessages: () async {
            loadOlderCalls += 1;
          },
        ),
      );

      final listFinder = find.byType(ListView).last;
      await tester.drag(listFinder, const Offset(0, -1200));
      await tester.pump();
      await tester.drag(listFinder, const Offset(0, 1200));
      await tester.pump();

      expect(loadOlderCalls, greaterThan(0));
    });
  });
}
