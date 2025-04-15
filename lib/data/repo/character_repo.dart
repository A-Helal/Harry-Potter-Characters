import 'package:bloc_basics/data/models/characters_model.dart';
import 'package:bloc_basics/data/services/character_service.dart';

class CharacterRepo {
  final CharacterService characterService;

  CharacterRepo({required this.characterService});

  Future<List<Character>> fetchAllCharacter() async {
    final characters = await characterService.getAllCharacters();
    return characters
        .map((character) => Character.fromJson(character))
        .toList();
  }
}
