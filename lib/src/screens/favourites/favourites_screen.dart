import 'package:flutter/material.dart';
import 'package:pokedex/src/screens/favourites/favourites_bloc.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/color_constants.dart';
import '../../core/constants/routes_constants.dart';
import '../../core/utils/custom_state.dart';
import '../../models/all_pokemon_model.dart';
import '../../shared_widgets/pokemon_containers/pokemon_list_view.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  CustomState<FavouritesScreen, FavouritesBloc> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends CustomState<FavouritesScreen, FavouritesBloc> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder<List<Results>>(
        stream: bloc.pokemonController.stream,
        builder: (context, snapshot) {
          return (snapshot.data != null && snapshot.data!.isNotEmpty) && snapshot.connectionState == ConnectionState.active
              ? PokemonListView(
                  onTap: (index) {
                    Navigator.pushNamed(context, RouteConstants.pokemonDetails,
                        arguments: {AppConstants.singlePokemonModel: snapshot.data![index]});
                  },
                  results: snapshot.data,
                )
              : (snapshot.data?.isEmpty ?? true && snapshot.connectionState == ConnectionState.active)
                  ? const Center(child: Text("There is no pokemons"))
                  : const Center(
                      child: CircularProgressIndicator(
                      color: ColorConstants.color_0xff3558CD,
                    ));
        });
  }

  @override
  void onStart() {
    bloc.startSubscription();
  }

  @override
  bool get wantKeepAlive => true;
}
