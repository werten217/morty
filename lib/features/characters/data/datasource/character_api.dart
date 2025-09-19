import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../model/characters_page_model.dart';

class CharacterApi {
  final Dio dio;

  CharacterApi(this.dio);

  Future<CharactersPageModel> fetchCharactersPage(int page) async {
    final path = '${ApiConstants.charactersEndpoint}?page=$page';
    final response = await dio.get(path);
    if (response.statusCode == 200) {
      final data = response.data as Map<String, dynamic>;
      return CharactersPageModel.fromJson(data);
    } else {
      throw Exception('API error: ${response.statusCode}');
    }
  }
}

