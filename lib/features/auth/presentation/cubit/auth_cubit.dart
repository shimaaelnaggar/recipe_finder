
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/features/auth/data/repos/auth_repo.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;
  AuthCubit(this.authRepo) : super(AuthInitial());

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    final result = await authRepo.signIn(email: email, password: password);
    result.fold(
      (error) => emit(LoginErrorState(error)),
      (_) => emit(LoginSuccessState()),
    );
  }


  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    emit(SignUpLoadingState());
    final result = await authRepo.signUp(email: email, password: password, name: name );
    result.fold(
      (error) => emit(SignUpErrorState(error)),
      (_) => emit(SignUpSuccessState()),
    );
  }
void getUser() async {
  emit(LoginLoadingState());

  final res = await authRepo.getUserData();

  res.fold(
    (error) => emit(LoginErrorState(error)),
    (data) => emit(LoginSuccessState()),
  );
}
}
