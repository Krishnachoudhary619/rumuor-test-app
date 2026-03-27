import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_response_model.freezed.dart';
part 'chat_response_model.g.dart';

@freezed
class ChatResponseModel with _$ChatResponseModel {
  const factory ChatResponseModel({
    @Default(false) bool status,
    @Default('') String reply,
  }) = _ChatResponseModel;

  factory ChatResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ChatResponseModelFromJson(json);
}
