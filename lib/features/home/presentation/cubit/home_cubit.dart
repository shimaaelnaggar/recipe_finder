import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:recipe_finder/features/home/data/models/category_model.dart';
import 'package:recipe_finder/features/home/data/repos/home_repo.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo homeRepo;
  List<CategoryModel> allCategories = [];

  HomeCubit({required this.homeRepo}) : super(HomeInitial());

  void getCategories() async {
    emit(HomeLoading());

    final result = await homeRepo.getCategories();

    result.fold((errorMessage) => emit(HomeError(errorMessage: errorMessage)), (
      categories,
    ) {
      allCategories = categories;
      emit(HomeLoaded(categories: List.from(allCategories)));
    });
  }

  void searchCategories(String query) {
    if (query.isEmpty) {
      emit(HomeLoaded(categories: List.from(allCategories)));
    } else {
      final filtered = allCategories
          .where(
            (cat) =>
                cat.categoryTitle.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
      emit(HomeLoaded(categories: filtered));
    }
  }
}
