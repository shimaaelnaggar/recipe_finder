part of 'meals_cubit.dart';

@immutable
sealed class MealsState {}

final class MealsInitial extends MealsState {}

final class MealsLoading extends MealsState {}

final class MealsLoaded extends MealsState {
  final List<MealModel> meals;

  MealsLoaded({required this.meals});
}

final class MealsError extends MealsState {
  final String errorMessage;

  MealsError({required this.errorMessage});
}
