
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:recipe_finder/features/home/data/models/category_model.dart';
import 'package:recipe_finder/features/home/data/repos/home_repo.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo homeRepo;

  HomeCubit({required this.homeRepo}) : super(HomeInitial());

  Future<void> getCategories() async {
    emit(HomeLoading());

    try {
      final res = await homeRepo.getCategories();
      res.fold(
        (error) {
          emit(HomeError(errorMessage: error));
        },
        (categories) {
          emit(HomeLoaded(categories: categories));
        },
      );
    } catch (e) {
      emit(HomeError(errorMessage: e.toString()));
    }
  }
}
