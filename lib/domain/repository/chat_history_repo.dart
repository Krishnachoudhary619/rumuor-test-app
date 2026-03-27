import 'package:dartz/dartz.dart';

import '../../core/exceptions/app_exception.dart';
import '../model/chat_message_model.dart';

abstract class ChatHistoryRepository {
  Future<Either<AppException, List<ChatMessageModel>>> getHistory();

  Future<Either<AppException, bool>> saveHistory(
    List<ChatMessageModel> messages,
  );

  Future<Either<AppException, bool>> clearHistory();
}
