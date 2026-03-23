import 'package:elevate_super_fitness/api/models/chat_message_model.dart';
import 'package:injectable/injectable.dart';

@singleton
class ChatMemoryService {
  final List<ChatMessageModel> _messages = [];
  int _nextMessageId = 1;

  Future<void> init() async {}

  int generateConversationId() => DateTime.now().microsecondsSinceEpoch;

  int addMessage({
    required int conversationId,
    required String text,
    required bool isUser,
    required String image,
    String? conversationTitle,
  }) {
    final msg = ChatMessageModel(
      id: _nextMessageId++,
      conversationId: conversationId,
      text: text,
      isUser: isUser,
      image: image,
      conversationTitle: conversationTitle,
    );
    _messages.add(msg);
    return msg.id;
  }

  List<ChatMessageModel> getMessages(int conversationId) {
    final list = _messages
        .where((m) => m.conversationId == conversationId)
        .toList(growable: false);
    list.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    return list;
  }

  List<int> getAllConversationIds() {
    if (_messages.isEmpty) return [];

    final map = <int, DateTime>{};
    for (final m in _messages) {
      final prev = map[m.conversationId];
      if (prev == null || m.createdAt.isAfter(prev)) {
        map[m.conversationId] = m.createdAt;
      }
    }

    final ids = map.keys.toList();
    ids.sort((a, b) => map[b]!.compareTo(map[a]!));
    return ids;
  }

  String? getConversationTitle(int conversationId) {
    final list = getMessages(conversationId);
    if (list.isEmpty) return null;
    return list.first.conversationTitle ?? list.first.text;
  }

  void close() {}
}
