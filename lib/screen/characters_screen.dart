import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/network/dio_client.dart';
import '../features/characters/data/datasource/character_api.dart';
import '../features/characters/data/repository/character_repository_impl.dart';
import '../core/theme/styles.dart';
import '../features/presentation/cubit/characters_cubit.dart';
import '../features/presentation/widgets/character_card.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late final CharactersCubit _cubit;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    final dioClient = DioClient();
    final api = CharacterApi(dioClient.dio);
    final repository = CharacterRepositoryImpl(api);

    _cubit = CharactersCubit(repository: repository);
    _cubit.loadInitial();

    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.pixels >=
            (_scrollController.position.maxScrollExtent - 200)) {
          _cubit.loadMore();
        }
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CharactersCubit>.value(
      value: _cubit,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Rick and Morty'),
          backgroundColor: AppColors.primary,
        ),
        body: BlocBuilder<CharactersCubit, CharactersState>(
          builder: (context, state) {
            if (state is CharactersLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CharactersLoaded) {
              final items = state.characters;
              return Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(12),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.72,
                      ),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return CharacterCard(character: items[index]);
                      },
                    ),
                  ),
                  if (state.isLoadingMore)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                ],
              );
            } else if (state is CharactersError) {
              return Center(child: Text('Ошибка: ${state.message}'));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
