import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/model/message_model.dart';

part 'chat_notifier_model.freezed.dart';
part 'chat_notifier_model.g.dart';

@JsonEnum(alwaysCreate: true)
enum ChatSender { user, assistant }

@freezed
class ChatNotifierModel with _$ChatNotifierModel {
  const factory ChatNotifierModel({
    @Default(<MessageModel>[]) List<MessageModel> messages,
    @Default(null) dynamic lastDoc,
    @Default(false) bool isPaginating,
  }) = _ChatNotifierModel;

  factory ChatNotifierModel.fromJson(Map<String, dynamic> json) =>
      _$ChatNotifierModelFromJson(json);
}
