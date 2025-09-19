import 'character.dart';

class CharactersPage {
  final List<Character> characters;
  final int currentPage;
  final int totalPages;
  final bool hasNext;

  CharactersPage({
    required this.characters,
    required this.currentPage,
    required this.totalPages,
    required this.hasNext,
  });
}
