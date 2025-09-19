import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/network/dio_client.dart';
import '../core/theme/dimensions.dart';
import '../features/characters/data/datasource/character_api.dart';
import '../features/characters/data/repository/character_repository_impl.dart';
import '../features/presentation/cubit/characters_cubit.dart';
import '../features/presentation/widgets/character_card.dart';
import 'character_detail_screen.dart';
import 'favorite_screen.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: const InputDecoration(
            hintText: "Search characters...",
            border: InputBorder.none,
          ),
          onChanged: (value) => setState(() => _searchQuery = value.toLowerCase()),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const FavoriteScreen()));
            },
          ),
        ],
      ),
      body: BlocBuilder<CharactersCubit, CharactersState>(
        builder: (context, state) {
          if (state is CharactersLoading) return const Center(child: CircularProgressIndicator());
          if (state is CharactersError) return Center(child: Text(state.message));
          if (state is CharactersLoaded) {
            final characters = state.characters.where((c) => c.name.toLowerCase().contains(_searchQuery)).toList();

            return NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification.metrics.pixels >= notification.metrics.maxScrollExtent - 200 &&
                    !state.isLoadingMore && state.hasNext) {
                  context.read<CharactersCubit>().loadMore();
                }
                return false;
              },
              child: GridView.builder(
                padding: const EdgeInsets.all(AppDimensions.paddingMedium),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.65,
                ),
                itemCount: characters.length + (state.hasNext ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < characters.length) {
                    final character = characters[index];
                    return CharacterCard(
                      character: character,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => CharacterDetailScreen(character: character)),
                      ),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
