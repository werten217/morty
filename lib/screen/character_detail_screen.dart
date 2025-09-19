import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/styles.dart';
import '../../../core/theme/dimensions.dart';
import '../features/domain/entities/character.dart';
import '../features/presentation/cubit/favorite_cubit.dart';

class CharacterDetailScreen extends StatelessWidget {
  final Character character;

  const CharacterDetailScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: AppColors.primary,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(character.name, overflow: TextOverflow.ellipsis),
              background: Hero(
                tag: 'character_${character.id}',
                child: Image.network(character.image, fit: BoxFit.cover),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow('Status', character.status),
                  const SizedBox(height: 16),
                  _buildInfoRow('Species', character.species),
                  const SizedBox(height: 24),
                  Center(child: _favoriteButton(context)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.title.copyWith(fontSize: 18)),
        const SizedBox(height: 4),
        Text(value, style: AppTextStyles.subtitle.copyWith(fontSize: 16)),
      ],
    );
  }

  Widget _favoriteButton(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        final isFavorite = context.read<FavoritesCubit>().isFavorite(character);
        return ElevatedButton.icon(
          onPressed: () {
            context.read<FavoritesCubit>().toggleFavorite(character);
          },
          icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
          label: Text(isFavorite ? 'Remove from Favorites' : 'Add to Favorites'),
          style: ElevatedButton.styleFrom(
            backgroundColor: isFavorite ? Colors.redAccent : AppColors.primary,
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        );
      },
    );
  }
}

