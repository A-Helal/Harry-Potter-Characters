import 'package:dio/dio.dart';

class CharacterService {
  Future<List<dynamic>> getAllCharacters() async {
    var dio = Dio();
    try {
      Response response =
      await dio.get('https://hp-api.onrender.com/api/characters');
      // Check if response data contains 'results'
      if (response.data != null) {
        return response.data;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
