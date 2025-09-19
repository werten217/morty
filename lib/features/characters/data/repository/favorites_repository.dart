

import '../../../domain/entities/character.dart';

class FavoritesRepository {
  final List<Character> _favorites = [];

  Future<List<Character>> getFavorites() async {
    return _favorites;
  }

  Future<void> toggleFavorite(Character character) async {
    final exists = _favorites.any((c) => c.id == character.id);
    if (exists) {
      _favorites.removeWhere((c) => c.id == character.id);
    } else {
      _favorites.add(character);
    }
  }

  bool isFavorite(Character character) {
    return _favorites.any((c) => c.id == character.id);
  }
}
