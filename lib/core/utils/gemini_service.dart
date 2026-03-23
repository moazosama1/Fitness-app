import 'package:injectable/injectable.dart';

@singleton
class GeminiService {
  Future<String> sendMessage(String message) async {
    final lower = message.toLowerCase();
    if (lower.contains('diet') ||
        lower.contains('meal') ||
        lower.contains('food')) {
      return 'Smart Coach: Keep each meal balanced with protein, vegetables, and quality carbs. 💪🥗';
    }
    if (lower.contains('workout') ||
        lower.contains('exercise') ||
        lower.contains('train')) {
      return 'Smart Coach: Start with 3-4 sessions weekly and progress gradually in intensity. 🔥';
    }
    if (lower.contains('sleep') || lower.contains('recovery')) {
      return 'Smart Coach: Aim for 7-8 hours sleep and at least one full rest day weekly. 🛌';
    }
    return 'Smart Coach: Great question. Focus on training consistency, smart nutrition, and recovery. 🏋️‍♂️';
  }

  Future<String> welcomeMessage() async {
    return "Welcome to Smart Coach 💪! Let's get started!";
  }
}
