import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/network/dio_client.dart';
import '../features/characters/data/datasource/character_api.dart';
import '../features/characters/data/repository/character_repository_impl.dart';
import '../features/presentation/cubit/characters_cubit.dart';
import '../features/presentation/widgets/character_card.dart';
import 'character_detail_screen.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final dioClient = DioClient();
    final characterApi = CharacterApi(dioClient.dio);
    final repository = CharacterRepositoryImpl(characterApi);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Characters'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by name...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchText = value.toLowerCase();
                });
              },
            ),
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) =>
        CharactersCubit(repository: repository)..loadInitial(),
        child: BlocBuilder<CharactersCubit, CharactersState>(
          builder: (context, state) {
            if (state is CharactersLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CharactersLoaded) {

              final characters = _searchText.isEmpty
                  ? state.characters
                  : state.characters
                  .where((c) =>
                  c.name.toLowerCase().contains(_searchText))
                  .toList();

              return NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification.metrics.pixels >=
                      notification.metrics.maxScrollExtent - 200 &&
                      !state.isLoadingMore &&
                      state.hasNext) {
                    context.read<CharactersCubit>().loadMore();
                  }
                  return false;
                },
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
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
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CharacterDetailScreen(character: character),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),

              );
            } else if (state is CharactersError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
