import 'package:flutter/material.dart';

import 'package:pokedex/locator.dart';
import 'package:pokedex/src/core/constants/color_constants.dart';
import 'package:pokedex/src/core/utils/custom_image_network.dart';
import 'package:pokedex/src/core/utils/custom_textstyle.dart';
import 'package:pokedex/src/core/utils/extentions/string_extension.dart';
import 'package:pokedex/src/models/single_pokemon_model.dart';

import '../../core/utils/formatters.dart';

class PokemonContainerView extends StatelessWidget {
  const PokemonContainerView(
      {Key? key, this.pokemonImage, this.pokemonID, this.pokemonName, this.pokemonType, this.pokemonBackgroundColor})
      : super(key: key);
  final String? pokemonImage;
  final String? pokemonID;
  final String? pokemonName;
  final List<Types>? pokemonType;
  final Color? pokemonBackgroundColor;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Ink(
              child: Align(
                child: Container(
                  decoration: BoxDecoration(
                      color: pokemonBackgroundColor,
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4))),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: CustomNetworkImage(
                      image: pokemonImage,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: FittedBox(
                child: Text(
                  pokemonID!,
                  textAlign: TextAlign.start,
                  style: locator<CustomTextStyle>()
                      .notoSansFont(color: ColorConstants.color_0xff6B6B6B, fontWeight: FontWeight.w400, fontSize: 12),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: FittedBox(
                  child: Text(
                pokemonName!.capitalize(),
                style: locator<CustomTextStyle>().notoSansFont(fontWeight: FontWeight.w600),
                textAlign: TextAlign.start,
              )),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                child: Row(
                  children: [
                    Text(
                      locator<Formatter>().pokemonTypesFormatter(pokemonType!),
                      style: locator<CustomTextStyle>()
                          .notoSansFont(color: ColorConstants.color_0xff6B6B6B, fontWeight: FontWeight.w400, fontSize: 12),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
