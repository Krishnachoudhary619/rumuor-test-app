// features/room/data/source/room_source.dart

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/services/firestore_service.dart';

part 'room_source.g.dart';

@riverpod
RoomSource roomSource(RoomSourceRef ref) {
  return RoomSource(ref.watch(firestoreServiceProvider));
}

class RoomSource {
  RoomSource(this._firestoreService);

  final FirestoreService _firestoreService;

  final _random = Random();

  String _generateRoomCode() {
    return (100000 + _random.nextInt(900000)).toString();
  }

  Future<String> createRoom() async {
    String roomId;
    bool exists = true;

    // 🔁 retry until unique
    do {
      roomId = _generateRoomCode();
      final doc = await _firestoreService.rooms.doc(roomId).get();
      exists = doc.exists;
    } while (exists);

    await _firestoreService.rooms.doc(roomId).set({
      'createdAt': FieldValue.serverTimestamp(),
      'lastMessage': null,
      'lastMessageAt': null,
    });

    return roomId;
  }

  Future<bool> checkRoomExists(String roomId) async {
    final doc = await _firestoreService.rooms.doc(roomId).get();
    return doc.exists;
  }
}
