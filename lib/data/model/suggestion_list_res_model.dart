import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/model/suggestion_model.dart';

part 'suggestion_list_res_model.freezed.dart';
part 'suggestion_list_res_model.g.dart';

@freezed
class SuggestionListResModel with _$SuggestionListResModel {
  const factory SuggestionListResModel({
    @Default('') String status,
    @Default([]) List<SuggestionModel> data,
    @Default(PaginationModel()) PaginationModel pagination,
  }) = _SuggestionListResModel;

  factory SuggestionListResModel.fromJson(Map<String, dynamic> json) =>
      _$SuggestionListResModelFromJson(json);
}

@freezed
class PaginationModel with _$PaginationModel {
  const factory PaginationModel({
    @JsonKey(name: 'current_page') @Default(1) int currentPage,
    @JsonKey(name: 'total_pages') @Default(0) int totalPages,
    @JsonKey(name: 'total_items') @Default(0) int totalItems,
    @Default(10) int limit,
    @JsonKey(name: 'has_next') @Default(false) bool hasNext,
    @JsonKey(name: 'has_previous') @Default(false) bool hasPrevious,
  }) = _PaginationModel;

  factory PaginationModel.fromJson(Map<String, dynamic> json) =>
      _$PaginationModelFromJson(json);
}
