import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/features/auth/presentation/views/login_view.dart';
import 'package:recipe_finder/features/auth/presentation/views/sign_up_view.dart';
import 'package:recipe_finder/features/home/presentation/views/home.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());

  List<Widget> views = [
    const Home(),
    const SignUpView(),
    const LoginView(),
  ];

  int currentIndex = 0;

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(ChangeBottomNavBarState());
  }
}
