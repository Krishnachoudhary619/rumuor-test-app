// features/chat/data/repository/chat_repo_impl.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/exceptions/app_exception.dart';
import '../../../core/extension/future.dart';
import '../../../domain/repository/chat_repo.dart';

import '../../domain/model/message_model.dart';
import '../source/chat_source.dart';

part 'chat_repo_impl.g.dart';

@riverpod
ChatRepository chatRepo(ChatRepoRef ref) {
  return ChatRepositoryImpl(ref.watch(chatSourceProvider));
}

class ChatRepositoryImpl implements ChatRepository {
  ChatRepositoryImpl(this._source);

  final ChatSource _source;

  @override
  Future<Either<AppException, void>> sendMessage({
    required String roomId,
    required String text,
    required String senderId,
    required String senderName,
  }) {
    return _source
        .sendMessage(
          roomId: roomId,
          text: text,
          senderId: senderId,
          senderName: senderName,
        )
        .guardFuture();
  }

  @override
  Future<Either<AppException, (List<MessageModel>, DocumentSnapshot<Object?>?)>>
      fetchMessages({
    required String roomId,
    DocumentSnapshot<Object?>? lastDoc,
  }) {
    return _source
        .fetchMessages(roomId: roomId, lastDoc: lastDoc)
        .guardFuture();
  }

  @override
  Stream<List<MessageModel>> getLatestMessages(String roomId) {
    return _source.getLatestMessages(roomId);
  }
}
