import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/theme/dimensions.dart';
import '../features/presentation/cubit/favorite_cubit.dart';
import '../features/presentation/widgets/character_card.dart';
import 'character_detail_screen.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favorites")),
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoading) return const Center(child: CircularProgressIndicator());
          if (state is FavoritesError) return Center(child: Text(state.message));
          if (state is FavoritesLoaded) {
            if (state.favorites.isEmpty) return const Center(child: Text("No favorites yet"));
            return GridView.builder(
              padding: const EdgeInsets.all(AppDimensions.paddingMedium),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.65,
              ),
              itemCount: state.favorites.length,
              itemBuilder: (context, index) {
                final character = state.favorites[index];
                return CharacterCard(
                  character: character,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => CharacterDetailScreen(character: character)),
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}


