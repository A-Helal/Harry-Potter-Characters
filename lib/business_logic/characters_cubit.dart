import 'package:bloc/bloc.dart';
import 'package:bloc_basics/data/models/characters_model.dart';
import 'package:bloc_basics/data/repo/character_repo.dart';
import 'package:meta/meta.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  CharacterRepo characterRepo;
   List<Character> characters =[];

  CharactersCubit(this.characterRepo) : super(CharactersInitial());

  List<Character> getAllCharacters() {
    characterRepo.fetchAllCharacter().then(
      (characters) {
        emit(CharactersLoaded(characters));
        this.characters = characters;
      },
    );
    return characters;
  }
}