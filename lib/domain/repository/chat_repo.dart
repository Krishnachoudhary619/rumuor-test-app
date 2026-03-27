import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../core/exceptions/app_exception.dart';

import '../model/message_model.dart';

abstract class ChatRepository {
  Future<Either<AppException, (List<MessageModel>, DocumentSnapshot?)>>
      fetchMessages({
    required String roomId,
    DocumentSnapshot? lastDoc,
  });

  Future<Either<AppException, void>> sendMessage({
    required String roomId,
    required String text,
    required String senderId,
    required String senderName,
  });
  Stream<List<MessageModel>> getLatestMessages(String roomId);
}
