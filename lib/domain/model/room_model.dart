// features/room/data/models/room_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'room_model.freezed.dart';
part 'room_model.g.dart';

@freezed
class RoomModel with _$RoomModel {
  const factory RoomModel({
    @Default('') String id,
    @Default('') String lastMessage,
    @Default('') String lastMessageAt,
    @Default('') String createdAt,
  }) = _RoomModel;

  factory RoomModel.fromJson(Map<String, dynamic> json) =>
      _$RoomModelFromJson(json);
}
