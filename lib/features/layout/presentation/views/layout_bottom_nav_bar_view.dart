import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/core/constants/app_colors.dart';
import 'package:recipe_finder/features/layout/presentation/cubit/layout_cubit.dart';

class LayoutBottomNavBarView extends StatelessWidget {
  const LayoutBottomNavBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit(),
      child: BlocBuilder<LayoutCubit, LayoutState>(
        builder: (context, state) {
          return Scaffold(
            body: context
                .read<LayoutCubit>()
                .views[context.read<LayoutCubit>().currentIndex],
            bottomNavigationBar: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: BottomNavigationBar(
                currentIndex: context.read<LayoutCubit>().currentIndex,
                onTap: (index) {
                  context.read<LayoutCubit>().changeBottomNavBar(index);
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.home),
                    ),
                    label: 'HOME',
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.favorite),
                    ),
                    label: 'FAVORITES',
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.person),
                    ),
                    label: 'PROFILE',
                  ),
                ],
                selectedItemColor: AppColors.primaryColor,
                unselectedItemColor: AppColors.darkGray,
                selectedIconTheme: const IconThemeData(size: 28),
                unselectedIconTheme: const IconThemeData(size: 24),
                selectedLabelStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                type: BottomNavigationBarType.fixed,
                backgroundColor: AppColors.secondaryColor,
              ),
            ),
          );
        },
      ),
    );
  }
}
