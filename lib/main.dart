import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/presentation/cubit/favorite_cubit.dart';
import 'screen/characters_screen.dart';

import 'core/network/dio_client.dart';
import 'features/characters/data/datasource/character_api.dart';
import 'features/characters/data/repository/character_repository_impl.dart';
import 'features/characters/data/repository/favorites_repository.dart';
import 'features/presentation/cubit/characters_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final dioClient = DioClient();
    final characterApi = CharacterApi(dioClient.dio);
    final charactersRepository = CharacterRepositoryImpl(characterApi);
    final favoritesRepository = FavoritesRepository();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CharactersCubit(repository: charactersRepository)..loadInitial(),
        ),
        BlocProvider(
          create: (_) => FavoritesCubit(favoritesRepository: favoritesRepository)..loadFavorites(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Rick & Morty',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const CharactersScreen(),
      ),
    );
  }
}
