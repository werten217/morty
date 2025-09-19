import '../entities/characters_page.dart';

abstract class CharacterRepository {
  Future<CharactersPage> getCharacters(int page);
}
