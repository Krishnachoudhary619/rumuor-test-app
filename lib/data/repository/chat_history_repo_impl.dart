import 'package:dartz/dartz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/exceptions/app_exception.dart';
import '../../domain/model/chat_message_model.dart';

import '../../domain/repository/chat_history_repo.dart';

import '../source/local/chat_history_source.dart';

part 'chat_history_repo_impl.g.dart';

@riverpod
ChatHistoryRepository chatHistoryRepository(ChatHistoryRepositoryRef ref) =>
    ChatHistoryRepositoryImpl(ref.read(chatHistorySourceProvider));

class ChatHistoryRepositoryImpl implements ChatHistoryRepository {
  ChatHistoryRepositoryImpl(this._source);

  final ChatHistorySource _source;

  @override
  Future<Either<AppException, List<ChatMessageModel>>> getHistory() async {
    try {
      final data = await _source.getMessages();
      return right(data);
    } catch (e) {
      return left(AppException(message: e.toString(), type: ErrorType.other));
    }
  }

  @override
  Future<Either<AppException, bool>> saveHistory(
    List<ChatMessageModel> messages,
  ) async {
    try {
      await _source.saveMessages(messages);
      return right(true);
    } catch (e) {
      return left(AppException(message: e.toString(), type: ErrorType.other));
    }
  }

  @override
  Future<Either<AppException, bool>> clearHistory() async {
    try {
      await _source.clear();
      return right(true);
    } catch (e) {
      return left(AppException(message: e.toString(), type: ErrorType.other));
    }
  }
}
