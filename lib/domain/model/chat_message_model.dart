import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message_model.freezed.dart';
part 'chat_message_model.g.dart';

@JsonEnum(alwaysCreate: true)
enum ChatSender { user, assistant }

@freezed
class ChatMessageModel with _$ChatMessageModel {
  const factory ChatMessageModel({
    @Default(ChatSender.user) ChatSender sender,
    @Default('') String message,
    @Default('') String date,
  }) = _ChatMessageModel;

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageModelFromJson(json);
}
