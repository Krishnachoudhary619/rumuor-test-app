import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/model/random_user_model.dart';
import '../../../domain/model/token.dart';
import '../../helper/pref_keys.dart';

part 'shar_pref.g.dart';

@riverpod
SharPrefRepo sharedPref(SharedPrefRef ref) =>
    SharPrefImpl(ref.read(secureSharedPrefProvider));

@riverpod
SharedPreferences secureSharedPref(SecureSharedPrefRef ref) =>
    throw Exception();

abstract class SharPrefRepo {
  Future<void> saveToken(Token token);
  Future<Token?> getToken();
  Future<void> clearAll();
  Future<void> saveRoomUser(String roomId, RandomUserModel user);
  Future<RandomUserModel?> getRoomUser(String roomId);
}

class SharPrefImpl extends SharPrefRepo {
  SharPrefImpl(this._pref);

  final SharedPreferences _pref;

  @override
  Future<void> saveToken(Token token) async {
    await _pref.setString(PrefKeys.token, jsonEncode(token));
  }

  @override
  Future<Token?> getToken() async {
    final encoded = _pref.getString(PrefKeys.token) ?? '';
    if (encoded.isEmpty) {
      return null;
    }
    return Token.fromJson(jsonDecode(encoded) as Map<String, dynamic>);
  }

  @override
  Future<void> clearAll() async {
    await _pref.clear();
  }

  @override
  Future<void> saveRoomUser(String roomId, RandomUserModel user) async {
    final key = '${PrefKeys.roomUser}_$roomId';

    await _pref.setString(
      key,
      jsonEncode(user.toJson()),
    );
  }

  @override
  Future<RandomUserModel?> getRoomUser(String roomId) async {
    final key = '${PrefKeys.roomUser}_$roomId';

    final data = _pref.getString(key);

    if (data == null || data.isEmpty) {
      return null;
    }

    return RandomUserModel.fromJson(
      jsonDecode(data),
    );
  }
}
