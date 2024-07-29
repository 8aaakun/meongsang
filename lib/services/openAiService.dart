import 'package:dart_openai/dart_openai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OpenAIService {
  Future<String> createModel(String sendMessage) async {
    OpenAI.apiKey = dotenv.env['OPEN_AI_API_KEY'] as String;
    OpenAI.requestsTimeOut = const Duration(seconds: 30); // 시간 제한 늘림

    // Assistant에게 대화의 방향성을 알려주는 메시지
    final systemMessage = OpenAIChatCompletionChoiceMessageModel(
      content: [
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          "너는 명상 앱의 AI야. 사용자의 입력을 보고 감정을 확인하고 짧게 세 문장 정도 편한 말투, 존댓말로 공감하는 말을 해줘. 그리고 내가 split하기 편하게 문장마다 '/' 넣어줘. 그리고 마지막에 사용자의 감정을 숫자로만 표시해줘. 띄어쓰기 하지말고 /1:분노, /2:슬픔, /3:행복, /4:판단불가",

        ),
      ],
      role: OpenAIChatMessageRole.system,
    );

    // 사용자가 보내는 메시지
    final userMessage = OpenAIChatCompletionChoiceMessageModel(
      content: [
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          sendMessage,
        ),
      ],
      role: OpenAIChatMessageRole.user,
    );

    final requestMessages = [
      systemMessage,
      userMessage,
    ];

    OpenAIChatCompletionModel chatCompletion =
    await OpenAI.instance.chat.create(
      model: 'gpt-4o-mini',
      messages: requestMessages,
      maxTokens: 250,
    );

    String message =
    chatCompletion.choices.first.message.content![0].text.toString();
    return message;
  }
}