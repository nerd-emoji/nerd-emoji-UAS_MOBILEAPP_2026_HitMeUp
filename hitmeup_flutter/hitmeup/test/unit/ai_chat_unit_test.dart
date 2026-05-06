import 'package:flutter_test/flutter_test.dart';
import 'package:hitmeup/screens/mainApp/ai_chat_screen.dart';

void main() {
  group('AiChatScreen Unit Tests', () {
    testWidgets('constructor stores context parameters correctly', (tester) async {
      const widget = AiChatScreen(
        contextUserId: 7,
        contextCommunityId: 9,
        contextTitle: 'Friend Chat',
      );

      expect(widget.contextUserId, 7);
      expect(widget.contextCommunityId, 9);
      expect(widget.contextTitle, 'Friend Chat');
      expect(widget.testSkipInitialization, isFalse);
    });

    testWidgets('test-only initialization flags can be provided', (tester) async {
      final widget = AiChatScreen(
        testSkipInitialization: true,
        testInitialIsLoading: false,
        testInitialIsInitializingChat: false,
        testInitialAiChatId: 10,
        testInitialHasMoreOlderMessages: true,
      );

      expect(widget.testSkipInitialization, isTrue);
      expect(widget.testInitialIsLoading, isFalse);
      expect(widget.testInitialIsInitializingChat, isFalse);
      expect(widget.testInitialAiChatId, 10);
      expect(widget.testInitialHasMoreOlderMessages, isTrue);
    });

    testWidgets('test callbacks can be provided', (tester) async {
      final widget = AiChatScreen(
        testSkipInitialization: true,
        testOnSendMessage: (text) {},
        testOnVoicePlayback: (url) {},
        testOnFriendRequest: (receiverId) {},
      );

      expect(widget.testOnSendMessage, isNotNull);
      expect(widget.testOnVoicePlayback, isNotNull);
      expect(widget.testOnFriendRequest, isNotNull);
    });
  });
}
