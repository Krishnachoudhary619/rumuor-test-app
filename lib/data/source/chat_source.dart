// features/chat/data/source/chat_source.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/services/firestore_service.dart';
import '../../domain/model/message_model.dart';
import '../helper/time_stamp_converter.dart';

part 'chat_source.g.dart';

@riverpod
ChatSource chatSource(ChatSourceRef ref) {
  return ChatSource(ref.watch(firestoreServiceProvider));
}

class ChatSource {
  ChatSource(this._firestoreService);

  final FirestoreService _firestoreService;

  Future<(List<MessageModel>, DocumentSnapshot?)> fetchMessages({
    required String roomId,
    DocumentSnapshot? lastDoc,
    int limit = 20,
  }) async {
    Query query = _firestoreService
        .messages(roomId)
        .orderBy('createdAt', descending: true)
        .limit(limit);

    if (lastDoc != null) {
      query = query.startAfterDocument(lastDoc);
    }

    final snapshot = await query.get();

    final messages = snapshot.docs.map(_mapDocToMessage).toList();

    final lastDocument = snapshot.docs.isNotEmpty ? snapshot.docs.last : null;

    return (messages, lastDocument);
  }

  Future<void> sendMessage({
    required String roomId,
    required String text,
    required String senderId,
    required String senderName,
  }) async {
    final ref = _firestoreService.messages(roomId);

    await ref.add({
      'text': text,
      'senderId': senderId,
      'senderName': senderName,
      'createdAt': FieldValue.serverTimestamp(),
    });

    await _firestoreService.rooms.doc(roomId).update({
      'lastMessage': text,
      'lastMessageAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<List<MessageModel>> getLatestMessages(String roomId) {
    return _firestoreService
        .messages(roomId)
        .orderBy('createdAt', descending: true)
        .limit(20)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map(_mapDocToMessage).toList();
    });
  }

  MessageModel _mapDocToMessage(DocumentSnapshot doc) {
    final data = (doc.data() ?? {}) as Map<String, dynamic>;

    return MessageModel(
      id: doc.id,
      text: data['text'] ?? '',
      senderId: data['senderId'] ?? '',
      senderName: data['senderName'] ?? '',
      createdAt: TimestampConverter.fromJson(data['createdAt']),
    );
  }
}
