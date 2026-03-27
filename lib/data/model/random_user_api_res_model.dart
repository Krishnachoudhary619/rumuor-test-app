import 'package:freezed_annotation/freezed_annotation.dart';

part 'random_user_api_res_model.freezed.dart';
part 'random_user_api_res_model.g.dart';

@freezed
class RandomUserResponse with _$RandomUserResponse {
  const factory RandomUserResponse({
    required List<Result> results,
  }) = _RandomUserResponse;

  factory RandomUserResponse.fromJson(Map<String, dynamic> json) =>
      _$RandomUserResponseFromJson(json);
}

@freezed
class Result with _$Result {
  const factory Result({
    required Name name,
    required Picture picture,
    required Login login,
  }) = _Result;

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
}

@freezed
class Name with _$Name {
  const factory Name({
    required String first,
    required String last,
  }) = _Name;

  factory Name.fromJson(Map<String, dynamic> json) => _$NameFromJson(json);
}

@freezed
class Picture with _$Picture {
  const factory Picture({
    required String medium,
  }) = _Picture;

  factory Picture.fromJson(Map<String, dynamic> json) =>
      _$PictureFromJson(json);
}

@freezed
class Login with _$Login {
  const factory Login({
    required String uuid,
  }) = _Login;

  factory Login.fromJson(Map<String, dynamic> json) => _$LoginFromJson(json);
}
