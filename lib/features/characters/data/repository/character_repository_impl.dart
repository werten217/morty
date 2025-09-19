
import '../../../domain/entities/character.dart';
import '../../../domain/entities/characters_page.dart';
import '../../../domain/repository/character_repository.dart';
import '../datasource/character_api.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterApi api;

  CharacterRepositoryImpl(this.api);

  @override
  Future<CharactersPage> getCharacters(int page) async {
    final pageModel = await api.fetchCharactersPage(page);
    final List<Character> characters =
    pageModel.results.map((e) => e.toEntity()).toList();
    final bool hasNext = pageModel.next != null;
    return CharactersPage(
      characters: characters,
      currentPage: page,
      totalPages: pageModel.pages,
      hasNext: hasNext,
    );
  }
}
