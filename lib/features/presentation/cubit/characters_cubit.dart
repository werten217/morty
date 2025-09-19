import 'package:bloc/bloc.dart';
import '../../domain/entities/character.dart';
import '../../domain/repository/character_repository.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharacterRepository repository;

  CharactersCubit({required this.repository}) : super(CharactersInitial());

  int _currentPage = 0;
  bool _isFetching = false;
  final List<Character> _characters = [];
  bool _hasNext = true;

  Future<void> loadInitial() async {
    _currentPage = 1;
    _characters.clear();
    _hasNext = true;

    emit(CharactersLoading());
    try {
      final page = await repository.getCharacters(_currentPage);
      _characters.addAll(page.characters);
      _hasNext = page.hasNext;
      emit(CharactersLoaded(
        characters: List.unmodifiable(_characters),
        currentPage: _currentPage,
        hasNext: _hasNext,
      ));
    } catch (e) {
      emit(CharactersError(e.toString()));
    }
  }

  Future<void> loadMore() async {
    if (_isFetching || !_hasNext) return;

    _isFetching = true;
    final prevState = state;
    if (prevState is CharactersLoaded) {
      emit(prevState.copyWith(isLoadingMore: true));
    }

    try {
      final nextPage = _currentPage + 1;
      final page = await repository.getCharacters(nextPage);
      _characters.addAll(page.characters);
      _currentPage = page.currentPage;
      _hasNext = page.hasNext;

      emit(CharactersLoaded(
        characters: List.unmodifiable(_characters),
        currentPage: _currentPage,
        hasNext: _hasNext,
        isLoadingMore: false,
      ));
    } catch (e) {
      emit(CharactersError(e.toString()));
    } finally {
      _isFetching = false;
    }
  }
}

