import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_finder/core/constants/app_colors.dart';
import 'package:recipe_finder/core/services/favourites_services.dart';
import 'package:recipe_finder/core/theme/text_styles.dart';
import 'package:recipe_finder/features/favorites/presentation/widgets/favorite_card.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'Favorites',
            style: AppTextStyles.s30Bold.copyWith(fontSize: 18),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, color: AppColors.darkGray),
          ),
        ],
      ),

      body: ValueListenableBuilder(
        valueListenable: FavoritesService.box.listenable(),
        builder: (context, box, _) {
          final meals = box.values.toList();

          if (meals.isEmpty) {
            return const Center(child: Text("No favorites yet"));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: meals.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) {
              final meal = meals[index];

              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    "/mealDetails",
                    arguments: meal["id"],
                  );
                },
                child: FavoriteCard(
                  name: meal["name"],
                  image: meal["image"],
                  id: meal['id'],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
