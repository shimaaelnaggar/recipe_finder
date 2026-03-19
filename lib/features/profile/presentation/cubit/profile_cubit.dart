import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:recipe_finder/features/profile/data/repos/profile_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;

  ProfileCubit(this.profileRepo) : super(ProfileInitial());

  void getProfile() async {
    emit(ProfileLoading());

    try {
      final data = await profileRepo.getProfile();

      emit(ProfileLoaded(data: data));
    } catch (e) {
      emit(ProfileError(errorMessage: e.toString()));
    }
  }

  Future<void> logout() async {
    emit(LogoutLoading());

    final result = await profileRepo.logout();

    result.fold(
      (error) => emit(LogoutError(error)),
      (_) => emit(LogoutSuccess()),
    );
  }

  Future<void> updateProfile({
    required String name,
    required String email,
  }) async {
    emit(ProfileLoading());

    try {
      await profileRepo.updateProfile(name: name, email: email);

      emit(ProfileUpdated());
    } catch (e) {
      emit(ProfileError(errorMessage: e.toString()));
    }
  }
}
