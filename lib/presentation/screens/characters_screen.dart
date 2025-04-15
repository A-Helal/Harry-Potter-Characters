import 'package:bloc_basics/business_logic/characters_cubit.dart';
import 'package:bloc_basics/consts/my_colors.dart';
import 'package:bloc_basics/data/models/characters_model.dart';
import 'package:bloc_basics/presentation/widgets/character_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  static const String routeName = "chars";

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<Character> allCharacters;
  late List<Character> searchedCharacter;
  bool isSearching = false;
  final searchController = TextEditingController();

  Widget buildSearchField() {
    return TextField(
        controller: searchController,
        decoration: const InputDecoration(
          hintText: 'Find a character...',
          hintStyle: TextStyle(color: MyColors.gray, fontSize: 18),
          border: InputBorder.none,
        ),
        style: const TextStyle(color: MyColors.gray, fontSize: 18),
        onChanged: (searchedForCharacter) {
          // searchedForCharacter: el7rf elly hd5loo
          searchForCharacters(searchedForCharacter);
        });
  }

  void searchForCharacters(String searchedForCharacter) {
    searchedCharacter = allCharacters
        .where((character) =>
            character.charName.toLowerCase().startsWith(searchedForCharacter))
        .toList();
    setState(() {});
  }

  List<Widget> buildAppBarActions() {
    if (isSearching) {
      return [
        IconButton(
          icon: const Icon(
            Icons.clear,
            color: MyColors.gray,
          ),
          onPressed: () {
            searchController.clear();
            Navigator.pop(context);
            setState(() {
              searchedCharacter = allCharacters;
              isSearching = false;
            });
          },
        ),
      ];
    } else {
      return [
        IconButton(
          icon: const Icon(
            Icons.search,
            color: MyColors.gray,
          ),
          onPressed: startSearch,
        ),
      ];
    }
  }

  void startSearch() {
    // in the weird line this, i act on flutter to tell him the start search is a new page ; all of this to put to me the arrow back in app bar
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: stopSearching));
    setState(() {
      isSearching = true;
    });
  }

  void stopSearching() {
    searchController.clear();
    setState(() {
      isSearching = false;
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  Widget builderOfdBloc() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoaded) {
          allCharacters = (state).characters;
          return buildLoadedListWidgets();
        } else {
          return showIndicator();
        }
      },
    );
  }

  Widget showIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: MyColors.yellow,
      ),
    );
  }

  Widget buildLoadedListWidgets() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.gray,
        child: Column(children: [
          buildCharactersList(),
        ]),
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
      ),
      itemCount: searchController.text.isEmpty
          ? allCharacters.length
          : searchedCharacter.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        return CharacterItem(
          character: searchController.text.isEmpty
              ? allCharacters[index]
              : searchedCharacter[index],
        );
      },
    );
  }

  Widget appBarTitle() {
    return const Text(
      "Characters",
      style: TextStyle(color: MyColors.gray),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.yellow,
        title: isSearching ? buildSearchField() : appBarTitle(),
        centerTitle: true,
        actions: buildAppBarActions(),
      ),
      body: builderOfdBloc(),
    );
  }
}
