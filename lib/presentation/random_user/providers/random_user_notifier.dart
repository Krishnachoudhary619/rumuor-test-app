import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../domain/repository/random_user_repo.dart';
import '../../../data/repository/random_user_repo_impl.dart';
import '../../../data/source/local/shar_pref.dart';
import '../../../domain/model/load_error_state.dart';
import '../../../domain/model/random_user_model.dart';

part 'random_user_notifier.g.dart';

@riverpod
class RandomUserNotifier extends _$RandomUserNotifier {
  late RandomUserRepository _repo;

  @override
  LoadErrorState<RandomUserModel?> build() {
    _repo = ref.read(randomUserRepoProvider);
    return LoadErrorState(data: null, loading: false);
  }

  Future<RandomUserModel> getOrCreateUser(String roomId) async {
    final pref = ref.read(sharedPrefProvider);

    final existingUser = await pref.getRoomUser(roomId);
    if (existingUser != null) {
      state = state.copyWith(
        data: RandomUserModel(
          id: existingUser.id,
          name: existingUser.name,
          avatar: existingUser.avatar,
        ),
        loading: false,
      );
      return existingUser;
    }

    final notifier = ref.read(randomUserNotifierProvider.notifier);
    await notifier.fetchUser();

    await pref.saveRoomUser(roomId, state.data ?? const RandomUserModel());

    return state.data ?? const RandomUserModel();
  }

  Future<void> fetchUser() async {
    state = state.copyWith(loading: true, error: '');

    final result = await _repo.getRandomUser();

    result.fold(
      (l) {
        state = state.copyWith(
          loading: false,
          error: l.message,
        );
      },
      (user) {
        state = state.copyWith(
          data: RandomUserModel(
            id: user.results.first.login.uuid,
            name:
                '${user.results.first.name.first} ${user.results.first.name.last}',
            avatar: user.results.first.picture.medium,
          ),
          loading: false,
        );
      },
    );
  }
}
