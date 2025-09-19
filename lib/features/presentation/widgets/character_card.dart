import 'package:flutter/material.dart';
import '../../../core/theme/styles.dart';
import '../../../core/theme/dimensions.dart';
import '../../domain/entities/character.dart';

class CharacterCard extends StatelessWidget {
  final Character character;
  final VoidCallback onTap;

  const CharacterCard({Key? key, required this.character, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
        ),
        elevation: 6,
        shadowColor: Colors.black26,
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: 'character_${character.id}',
              child: Image.network(
                character.image,
                height: AppDimensions.imageHeight,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    character.name,
                    style: AppTextStyles.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${character.species} • ${character.status}',
                    style: AppTextStyles.subtitle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}






