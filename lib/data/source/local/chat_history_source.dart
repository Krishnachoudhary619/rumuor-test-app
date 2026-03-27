import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';

// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/model/chat_message_model.dart';

part 'chat_history_source.g.dart';

@riverpod
ChatHistorySource chatHistorySource(ChatHistorySourceRef ref) {
  return ChatHistorySource(ref.read(chatHistorySharedPrefProvider));
}

@riverpod
SharedPreferences chatHistorySharedPref(ChatHistorySharedPrefRef ref) =>
    throw Exception();

class ChatHistorySource {
  ChatHistorySource(this._pref);

  final SharedPreferences _pref;
  static const _key = 'chat_history';

  Future<void> saveMessages(List<ChatMessageModel> messages) async {
    final jsonList = messages.map((e) => e.toJson()).toList();

    await _pref.setString(_key, jsonEncode(jsonList));
  }

  Future<List<ChatMessageModel>> getMessages() async {
    final data = _pref.getString(_key);

    if (data == null) {
      return [];
    }

    final decoded = jsonDecode(data) as List;

    return decoded.map((e) => ChatMessageModel.fromJson(e)).toList();
  }

  Future<void> clear() async {
    await _pref.remove(_key);
  }
}
