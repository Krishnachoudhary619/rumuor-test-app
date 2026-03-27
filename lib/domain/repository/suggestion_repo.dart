import 'package:dartz/dartz.dart';

import '../../core/exceptions/app_exception.dart';
import '../../data/model/suggestion_list_res_model.dart';

abstract class SuggestionRepository {
  Future<Either<AppException, SuggestionListResModel>> getSuggestionList({
    required int page,
    required int limit,
  });
}
