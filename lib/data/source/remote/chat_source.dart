import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/constants/constants.dart';
import '../../../domain/model/chat_response_model.dart';
import '../../helper/dio_instance.dart';

part 'chat_source.g.dart';

@riverpod
ChatSource chatSource(ChatSourceRef ref) {
  return ChatSource(ref.watch(dioInstanceProvider));
}

@RestApi()
abstract class ChatSource {
  factory ChatSource(Dio dio) => _ChatSource(dio);

  @POST(Constants.sendChatMsg)
  Future<ChatResponseModel> sendMessage(
    @Body() Map<String, dynamic> body,
  );
}
