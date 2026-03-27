import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/constants/constants.dart';
import '../../helper/dio_instance.dart';

import '../../model/suggestion_list_res_model.dart';

part 'suggestion_source.g.dart';

@riverpod
SuggestionSource suggestionSource(SuggestionSourceRef ref) {
  return SuggestionSource(ref.watch(dioInstanceProvider));
}

@RestApi()
abstract class SuggestionSource {
  factory SuggestionSource(Dio _dio) => _SuggestionSource(_dio);
  @GET(Constants.getSuggestionList)
  Future<SuggestionListResModel> getSuggestionList(
    @Path() int page,
    @Path() int limit,
  );
}
