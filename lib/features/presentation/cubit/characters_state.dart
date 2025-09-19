part of 'characters_cubit.dart';

sealed class CharactersState {
  const CharactersState();
}

final class CharactersInitial extends CharactersState {}
final class CharactersLoading extends CharactersState {}

final class CharactersLoaded extends CharactersState {
  final List<Character> characters;
  final int currentPage;
  final bool hasNext;
  final bool isLoadingMore;

  const CharactersLoaded({
    required this.characters,
    required this.currentPage,
    required this.hasNext,
    this.isLoadingMore = false,
  });

  CharactersLoaded copyWith({
    List<Character>? characters,
    int? currentPage,
    bool? hasNext,
    bool? isLoadingMore,
  }) {
    return CharactersLoaded(
      characters: characters ?? this.characters,
      currentPage: currentPage ?? this.currentPage,
      hasNext: hasNext ?? this.hasNext,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

final class CharactersError extends CharactersState {
  final String message;
  const CharactersError(this.message);
}

