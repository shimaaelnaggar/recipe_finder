part of 'meals_cubit.dart';

@immutable
sealed class MealDetailsState {}

final class MealDetailsInitial extends MealDetailsState {}

final class MealDetailsLoading extends MealDetailsState {}

final class MealDetailsLoaded extends MealDetailsState {
  final MealDetailsModel meal;

  MealDetailsLoaded({required this.meal});
}

final class MealDetailsError extends MealDetailsState {
  final String errorMessage;

  MealDetailsError({required this.errorMessage});
}
