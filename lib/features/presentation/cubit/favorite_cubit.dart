import 'package:flutter_bloc/flutter_bloc.dart';
import '../../characters/data/repository/favorites_repository.dart';
import '../../domain/entities/character.dart';

abstract class FavoritesState {}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<Character> favorites;

  FavoritesLoaded(this.favorites);

  bool isFavorite(Character character) {
    return favorites.any((c) => c.id == character.id);
  }
}

class FavoritesError extends FavoritesState {
  final String message;
  FavoritesError(this.message);
}

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesRepository favoritesRepository;

  FavoritesCubit({required this.favoritesRepository}) : super(FavoritesInitial());

  Future<void> loadFavorites() async {
    try {
      emit(FavoritesLoading());
      final favorites = await favoritesRepository.getFavorites();
      emit(FavoritesLoaded(favorites));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> toggleFavorite(Character character) async {
    try {
      await favoritesRepository.toggleFavorite(character);
      final favorites = await favoritesRepository.getFavorites();
      emit(FavoritesLoaded(favorites));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  bool isFavorite(Character character) {
    if (state is FavoritesLoaded) {
      return (state as FavoritesLoaded).isFavorite(character);
    }
    return false;
  }
}

