import 'package:bloc_basics/consts/my_colors.dart';
import 'package:bloc_basics/data/models/characters_model.dart';
import 'package:bloc_basics/presentation/screens/character_details.dart';
import 'package:flutter/material.dart';

class CharacterItem extends StatelessWidget {
  const CharacterItem({required this.character, super.key});

  final Character? character;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: MyColors.white),
      ),
      child: GestureDetector(
        onTap: ()=>Navigator.pushNamed(context,CharactersDetailsScreen.routeName,arguments: character),
        child: GridTile(
          footer: Hero(
            tag: character!.charId,
            child: Container(
              width: double.infinity,
              color: Colors.black54,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Text(
                character!.charName,
                style: const TextStyle(
                  height: 1.5,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: MyColors.white,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          child: Container(
            color: MyColors.gray,
            child: character!.img.isNotEmpty
                ? FadeInImage.assetNetwork(
                    width: double.infinity,
                    height: double.infinity,
                    placeholder: "assets/images/loading.gif",
                    image: character!.img,
                    fit: BoxFit.cover,
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }
}
