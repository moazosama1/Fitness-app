import 'package:equatable/equatable.dart';

class ChatMessageModel extends Equatable {
  int id;

  int conversationId;
  String text;
  bool isUser;
  String image;
  String? conversationTitle;

  DateTime createdAt;

  ChatMessageModel({
    this.id = 0,
    required this.conversationId,
    required this.text,
    required this.isUser,
    required this.image,
    this.conversationTitle,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  @override
  List<Object?> get props => [
    id,
    conversationId,
    text,
    isUser,
    image,
    conversationTitle,
    createdAt,
  ];
}
