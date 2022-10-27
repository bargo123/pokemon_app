import 'package:flutter/material.dart';

import 'package:pokedex/locator.dart';
import 'package:pokedex/src/core/constants/app_constants.dart';
import 'package:pokedex/src/core/constants/color_constants.dart';
import 'package:pokedex/src/core/utils/custom_image_network.dart';
import 'package:pokedex/src/core/utils/custom_state.dart';
import 'package:pokedex/src/core/utils/custom_textstyle.dart';
import 'package:pokedex/src/core/utils/extentions/size_extension.dart';
import 'package:pokedex/src/core/utils/extentions/string_extension.dart';
import 'package:pokedex/src/core/utils/formatters.dart';
import 'package:pokedex/src/models/all_pokemon_model.dart';
import 'package:pokedex/src/screens/pokemon_details/pokemon_details_bloc.dart';
import 'package:pokedex/src/shared_widgets/pokemon_details.dart/pokemon_details_stats.dart';

class PokemonDetails extends StatefulWidget {
  const PokemonDetails({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PokemonDetailsState createState() => _PokemonDetailsState();
}

class _PokemonDetailsState extends CustomState<PokemonDetails, PokemonDetailsBloc> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    _handleReadingArguments(arguments: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>);
    return Scaffold(
        floatingActionButton: SizedBox(
          child: StreamBuilder<bool?>(
              stream: bloc.favouritesStatusControllers.stream,
              builder: (context, snapshot) {
                return snapshot.data != null
                    ? FloatingActionButton.extended(
                        backgroundColor:
                            snapshot.data == false ? ColorConstants.color_0xff3558CD : ColorConstants.color_0xffD5DEFF,
                        onPressed: () async {
                          await bloc.removeOrAddPokemonWatchList();
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(36),
                        ),
                        label: Text(
                          snapshot.data == false ? "Mark as favourite" : "Remove from favourites",
                          style: locator<CustomTextStyle>().notoSansFont(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: snapshot.data == false ? ColorConstants.color_0xffFFFFFF : ColorConstants.color_0xff3558CD),
                        ),
                      )
                    : Container();
              }),
        ),
        body: CustomScrollView(slivers: [
          SliverAppBar(
            backgroundColor: bloc.pokemonResult.pokemonDetails?.color,
            leading: InkWell(
              borderRadius: BorderRadius.circular(30),
              child: const Icon(Icons.arrow_back_ios, size: 18, color: ColorConstants.color_0xff000000),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 2,
                ),
                AspectRatio(
                  aspectRatio: 12 / 6,
                  child: Container(
                      color: bloc.pokemonResult.pokemonDetails?.color,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, bottom: 16, left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  bloc.pokemonResult.name!.capitalize(),
                                  textAlign: TextAlign.start,
                                  style: locator<CustomTextStyle>().notoSansFont(
                                      fontSize: 32, fontWeight: FontWeight.w700, color: ColorConstants.color_0xff161A33),
                                ),
                                Text(
                                  locator<Formatter>().pokemonTypesFormatter(bloc.pokemonResult.pokemonDetails!.types!),
                                  style: locator<CustomTextStyle>().notoSansFont(
                                      fontSize: 16, fontWeight: FontWeight.w400, color: ColorConstants.color_0xff161A33),
                                ),
                                const Spacer(
                                  flex: 1,
                                ),
                                Text(
                                  locator<Formatter>().idFormatter(bloc.pokemonResult.pokemonDetails!.id!),
                                  style: locator<CustomTextStyle>().notoSansFont(
                                      fontSize: 16, fontWeight: FontWeight.w400, color: ColorConstants.color_0xff161A33),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                          ),
                          Stack(
                            fit: StackFit.loose,
                            alignment: Alignment.bottomRight,
                            children: [
                              Image.asset(
                                "assets/images/pokemon_holder_ic.png",
                                fit: BoxFit.fitWidth,
                                color: HSLColor.fromColor(bloc.pokemonResult.pokemonDetails!.color!).withLightness(0.7).toColor(),
                                height: MediaQuery.of(context).size.height * 0.2,
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    right: 8,
                                  ),
                                  child: SizedBox(
                                    height: 0.17.ofScreenHeight(context),
                                    width: 0.17.ofScreenHeight(context),
                                    child: CustomNetworkImage(
                                      imageScale: 3,
                                      image: bloc.pokemonResult.pokemonDetails!.sprites!.other!.officialArtwork!.frontDefault,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      )),
                ),
                Container(
                  color: ColorConstants.color_0xffFFFFFF,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0, top: 18, bottom: 18),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            getPokemonHeaderInfoKeys("Height"),
                            getPokemonHeaderInfoKeys("Weight"),
                            getPokemonHeaderInfoKeys("BMI"),
                            Expanded(
                              flex: 30,
                              child: Container(),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            getPokemonHeaderInfoValues(bloc.pokemonResult.pokemonDetails?.height?.toString() ?? "0"),
                            getPokemonHeaderInfoValues(bloc.pokemonResult.pokemonDetails?.weight?.toString() ?? "0"),
                            getPokemonHeaderInfoValues(
                                "${((bloc.pokemonResult.pokemonDetails?.weight ?? 0) / ((bloc.pokemonResult.pokemonDetails?.height ?? 0) ^ 2)).toStringAsFixed(3)}"),
                            Expanded(
                              flex: 30,
                              child: Container(),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  color: ColorConstants.color_0xffFFFFFF,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          "Base stats",
                          style: locator<CustomTextStyle>()
                              .notoSansFont(fontSize: 16, fontWeight: FontWeight.w600, color: ColorConstants.color_0xff161A33),
                        ),
                      ),
                      const Divider(color: ColorConstants.color_0xffE8E8E8),
                      for (int i = 0; i < bloc.sortBaseStats().length; i++)
                        PokemonStat(
                          stat: bloc.sortBaseStats().keys.toList()[i],
                          statValue: bloc.sortBaseStats().values.toList()[i],
                          valueColor: bloc.progressBarColors(bloc.sortBaseStats().values.toList()[i]!),
                        ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          )
        ]));
  }

  Widget getPokemonHeaderInfoKeys(String keys) {
    return Expanded(
      flex: 25,
      child: Text(
        keys,
        style: locator<CustomTextStyle>()
            .notoSansFont(fontSize: 13, fontWeight: FontWeight.w500, color: ColorConstants.color_0xff6B6B6B),
      ),
    );
  }

  Widget getPokemonHeaderInfoValues(String values) {
    return Expanded(
      flex: 25,
      child: Text(
        values,
        style: locator<CustomTextStyle>()
            .notoSansFont(fontSize: 15, fontWeight: FontWeight.w400, color: ColorConstants.color_0xff161A33),
      ),
    );
  }

  void _handleReadingArguments({required Map<String, dynamic> arguments}) {
    bloc.pokemonResult = arguments[AppConstants.singlePokemonModel] as Results;
  }

  @override
  void onStart() {
    bloc.startSubscription();
  }

  @override
  bool get wantKeepAlive => false;
}
