// domain/model/random_user.dart

import 'package:freezed_annotation/freezed_annotation.dart';

part 'random_user_model.freezed.dart';
part 'random_user_model.g.dart';

@freezed
class RandomUserModel with _$RandomUserModel {
  const factory RandomUserModel({
    @Default('') String id,
    @Default('') String name,
    @Default('') String avatar,
  }) = _RandomUserModel;

  factory RandomUserModel.fromJson(Map<String, dynamic> json) =>
      _$RandomUserModelFromJson(json);
}
