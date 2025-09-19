import 'character_model.dart';

class CharactersPageModel {
  final List<CharacterModel> results;
  final int pages;
  final int count;
  final String? next;

  CharactersPageModel({
    required this.results,
    required this.pages,
    required this.count,
    this.next,
  });

  factory CharactersPageModel.fromJson(Map<String, dynamic> json) {
    final info = json['info'] as Map<String, dynamic>;
    final resultsList = (json['results'] as List<dynamic>)
        .map((e) => CharacterModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return CharactersPageModel(
      results: resultsList,
      pages: (info['pages'] as num).toInt(),
      count: (info['count'] as num).toInt(),
      next: info['next'] as String?,
    );
  }
}
