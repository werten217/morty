import 'package:flutter/material.dart';
import '../../../core/theme/styles.dart';
import '../../../core/theme/dimensions.dart';
import '../../domain/entities/character.dart';

class CharacterCard extends StatelessWidget {
  final Character character;
  const CharacterCard({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
      ),
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius:
            const BorderRadius.vertical(top: Radius.circular(AppDimensions.cardRadius)),
            child: Image.network(
              character.image,
              height: AppDimensions.imageHeight,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(character.name, style: AppTextStyles.title),
                const SizedBox(height: 4),
                Text('${character.species} • ${character.status}', style: AppTextStyles.subtitle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
