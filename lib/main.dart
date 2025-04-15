import 'package:bloc_basics/business_logic/characters_cubit.dart';
import 'package:bloc_basics/data/repo/character_repo.dart';
import 'package:bloc_basics/data/services/character_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/screens/character_details.dart';
import 'presentation/screens/characters_screen.dart';

void main() {
  runApp(HarryPotter());
}

class HarryPotter extends StatelessWidget {
  late CharacterRepo characterRepo;
  late CharactersCubit charactersCubit;

  HarryPotter({super.key}) {
    characterRepo = CharacterRepo(characterService: CharacterService());
    charactersCubit = CharactersCubit(characterRepo);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => charactersCubit,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: CharactersScreen.routeName,
        routes: {
          CharactersScreen.routeName: (context) => const CharactersScreen(),
          CharactersDetailsScreen.routeName: (context) =>
              CharactersDetailsScreen(),
        },
      ),
    );
  }
}
