import 'package:elevate_super_fitness/api/models/chat_message_model.dart';
import 'package:elevate_super_fitness/core/constants/app_images.dart';
import 'package:elevate_super_fitness/core/constants/constant_fake_data.dart';
import 'package:elevate_super_fitness/core/utils/chat_memory_service.dart';
import 'package:elevate_super_fitness/core/utils/gemini_service.dart';
import 'package:elevate_super_fitness/domain/use_cases/get_user_logged_data_use_case.dart';
import 'package:elevate_super_fitness/presentation/smart_coach_page/view_model/smart_coach_events.dart';
import 'package:elevate_super_fitness/presentation/smart_coach_page/view_model/smart_coach_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SmartCoachViewModel extends Cubit<SmartCoachStates> {
  final ChatMemoryService _db;
  static const Duration _fakeDelay = Duration(milliseconds: 450);

  SmartCoachViewModel(
    this._db,
    GeminiService geminiService,
    GetUserLoggedDataUseCase getUserLoggedDataUseCase,
  ) : super(const SmartCoachStates());

  final TextEditingController inputController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  void doIntent(SmartCoachEvents event) {
    switch (event) {
      case OnLoadWelcomeMessageEvent():
        _loadWelcomeMessage();
        break;
      case OnSendMessageEvent():
        _sendMessage();
        break;
      case OnLoadConversationsEvent():
        _loadConversations();
        break;
      case OnLoadSelectedConversationEvent():
        _loadSelectedConversation(event.conversationId);
        break;
      case OnGetUserLoggedDataEvent():
        _getUserLoggedData();
        break;
    }
  }

  Future<void> _loadWelcomeMessage() async {
    final newCid = _db.generateConversationId();

    const welcome =
        'Welcome to Smart Coach. I am running in fake test mode and can help with workouts, food, and recovery tips.';
    _db.addMessage(
      conversationId: newCid,
      text: welcome,
      isUser: false,
      image: AppImages.aiImage,
    );

    final msgs = _db.getMessages(newCid);
    emit(
      state.copyWith(
        currentConversationId: newCid,
        messagesListSuccess: msgs,
        conversationIds: _db.getAllConversationIds(),
      ),
    );
  }

  Future<void> _sendMessage() async {
    final text = inputController.text.trim();
    if (text.isEmpty) return;

    var cid = state.currentConversationId;
    cid ??= _db.generateConversationId();

    final isFirstMessage = state.messagesListSuccess.isEmpty;

    const image = AppImages.userImage;

    _db.addMessage(conversationId: cid, text: text, isUser: true, image: image);

    if (isFirstMessage) {
      final updatedTitles = Map<int, String>.from(state.conversationTitles);
      updatedTitles[cid] = text;
      emit(state.copyWith(conversationTitles: updatedTitles));
    }

    emit(
      state.copyWith(
        currentConversationId: cid,
        messagesListSuccess: [
          ...state.messagesListSuccess,
          ChatMessageModel(
            conversationId: cid,
            text: text,
            isUser: true,
            image: image,
          ),
        ],
        conversationIds: _db.getAllConversationIds(),
      ),
    );

    _scrollToBottom();
    inputController.clear();

    emit(state.copyWith(isLoading: true));
    await Future.delayed(_fakeDelay);
    final replyText = _buildFakeReply(text);

    _db.addMessage(
      conversationId: cid,
      text: replyText,
      isUser: false,
      image: AppImages.aiImage,
    );

    emit(
      state.copyWith(
        isLoading: false,
        messagesListSuccess: [
          ...state.messagesListSuccess,
          ChatMessageModel(
            conversationId: cid,
            text: replyText,
            isUser: false,
            image: AppImages.aiImage,
          ),
        ],
        conversationIds: _db.getAllConversationIds(),
      ),
    );

    _scrollToBottom();
  }

  String _buildFakeReply(String userMessage) {
    final text = userMessage.toLowerCase();
    if (text.contains('diet') ||
        text.contains('food') ||
        text.contains('meal')) {
      return 'Fake Coach: Keep meals simple. Aim for protein + complex carbs + vegetables in each main meal.';
    }
    if (text.contains('workout') ||
        text.contains('exercise') ||
        text.contains('train')) {
      return 'Fake Coach: Start with 3 sessions weekly, focus on compound moves, and increase intensity gradually.';
    }
    if (text.contains('sleep') || text.contains('recovery')) {
      return 'Fake Coach: Target 7-8 hours sleep and include at least 1 full rest day each week.';
    }
    return 'Fake Coach: Good question. For test mode, try balanced training, consistent nutrition, and proper recovery.';
  }

  Future<void> _getUserLoggedData() async {
    emit(state.copyWith(loggedUserDataLoading: true));
    await Future.delayed(const Duration(milliseconds: 200));
    emit(
      state.copyWith(
        loggedUserDataLoading: false,
        loggedUserDataSuccess: AppFakeData.profileUser,
      ),
    );
  }

  void _loadConversations() {
    final ids = _db.getAllConversationIds();
    final titles = <int, String>{};

    for (final id in ids) {
      final msgs = _db.getMessages(id);
      if (msgs.isNotEmpty) {
        final firstMsg = msgs.firstWhere(
          (m) => m.isUser,
          orElse: () => msgs.first,
        );
        titles[id] = firstMsg.text;
      }
    }

    emit(state.copyWith(conversationIds: ids, conversationTitles: titles));
  }

  void _loadSelectedConversation(int conversationId) {
    final msgs = _db.getMessages(conversationId);
    emit(
      state.copyWith(
        currentConversationId: conversationId,
        messagesListSuccess: msgs,
        conversationIds: _db.getAllConversationIds(),
      ),
    );
    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (!scrollController.hasClients) return;
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Future<void> close() {
    inputController.dispose();
    scrollController.dispose();
    return super.close();
  }
}
