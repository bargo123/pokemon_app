import 'package:flutter/material.dart';
import 'package:pokedex/src/core/utils/extentions/size_extension.dart';

import 'package:pokedex/src/core/utils/formatters.dart';
import 'package:pokedex/src/models/all_pokemon_model.dart';
import 'package:pokedex/src/shared_widgets/pokemon_containers/pokemon_container_view.dart';

import '../../core/constants/color_constants.dart';

class PokemonListView extends StatelessWidget {
  const PokemonListView({Key? key, this.results, this.scrollController, this.onTap}) : super(key: key);
  final List<Results>? results;
  final ScrollController? scrollController;
  final Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    var maxWidth = 500;
    var width = MediaQuery.of(context).size.width;
    var columns = (width ~/ maxWidth) + 1.1;
    var columnWidth = width / columns;
    var aspectRatio = columnWidth / 700;
    return GridView.builder(
      itemCount: results!.length,
      controller: scrollController,
      padding: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 15),
      itemBuilder: (BuildContext context, int index) {
        return Material(
          color: ColorConstants.color_0xffFFFFFF,
          child: InkWell(
            onTap: () {
              onTap!(index);
            },
            child: Ink(
              child: PokemonContainerView(
                pokemonID: Formatter().idFormatter(results![index].pokemonDetails!.id!),
                pokemonImage: results![index].pokemonDetails!.sprites!.other!.officialArtwork!.frontDefault,
                pokemonName: results![index].name,
                pokemonType: results?[index].pokemonDetails?.types,
                pokemonBackgroundColor: results?[index].pokemonDetails?.color,
              ),
            ),
          ),
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: aspectRatio, crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10),
    );
  }
}
