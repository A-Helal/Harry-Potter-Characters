import 'package:bloc_basics/consts/my_colors.dart';
import 'package:bloc_basics/data/models/characters_model.dart';
import 'package:flutter/material.dart';

class CharactersDetailsScreen extends StatelessWidget {
  static const String routeName = "Details";

  const CharactersDetailsScreen({super.key});

  Widget buildAppBarList(Character character, BuildContext context) {
    return SliverAppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
      ),
      automaticallyImplyLeading: false,
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.gray,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          character.charName,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: MyColors.yellow,
          ),
        ),
        background: Hero(
          tag: character.charId,
          child: Image.network(
            character.img,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget characterInfo(String title, String val) {
    return RichText(
      maxLines: 1,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: MyColors.white,
            ),
          ),
          TextSpan(
            text: val,
            style: const TextStyle(
              fontSize: 18,
              color: MyColors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      color: MyColors.yellow,
      endIndent: endIndent,
      height: 10,
      thickness: 3,
    );
  }

  @override
  Widget build(BuildContext context) {
    final character = ModalRoute.of(context)!.settings.arguments as Character;
    return Scaffold(
      backgroundColor: MyColors.gray,
      body: CustomScrollView(slivers: [
        buildAppBarList(character, context),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Container(
                margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    characterInfo("Name: ", character.charName),
                    buildDivider(305),
                    characterInfo("id: ", character.charId.toString()),
                    buildDivider(342),
                    characterInfo("Gender: ", character.gender),
                    buildDivider(290),
                    characterInfo("Actor name: ", character.actorName),
                    buildDivider(248),
                    characterInfo("Alive?: ", character.status.toString()),
                    buildDivider(302),
                  ],
                ),
              ),
              const SizedBox(
                height: 580,
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
