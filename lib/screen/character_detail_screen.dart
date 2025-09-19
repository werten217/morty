import 'package:flutter/material.dart';
import '../../../core/theme/styles.dart';
import '../../../core/theme/dimensions.dart';
import '../features/domain/entities/character.dart';

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
              title: Text(character.name),
              background: Hero(
                tag: 'character_${character.id}',
                child: Image.network(
                  character.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Status', style: AppTextStyles.title.copyWith(fontSize: 18)),
                  const SizedBox(height: 4),
                  Text(character.status, style: AppTextStyles.subtitle.copyWith(fontSize: 16)),
                  const SizedBox(height: 16),
                  Text('Species', style: AppTextStyles.title.copyWith(fontSize: 18)),
                  const SizedBox(height: 4),
                  Text(character.species, style: AppTextStyles.subtitle.copyWith(fontSize: 16)),
                  const SizedBox(height: 16),
                  Text('Description', style: AppTextStyles.title.copyWith(fontSize: 18)),
                  const SizedBox(height: 8),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                        'Suspendisse varius enim in eros elementum tristique. '
                        'Duis cursus, mi quis viverra ornare, eros dolor interdum nulla, '
                        'ut commodo diam libero vitae erat.',
                    style: AppTextStyles.subtitle.copyWith(fontSize: 15, height: 1.5),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_border),
                      label: const Text('Add to Favorites'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
