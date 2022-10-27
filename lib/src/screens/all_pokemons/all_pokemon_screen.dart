import 'package:flutter/material.dart';
import 'package:pokedex/src/core/constants/app_constants.dart';
import 'package:pokedex/src/core/constants/color_constants.dart';
import 'package:pokedex/src/core/constants/routes_constants.dart';
import 'package:pokedex/src/core/utils/custom_state.dart';
import 'package:pokedex/src/models/all_pokemon_model.dart';
import 'package:pokedex/src/screens/all_pokemons/all_pokemon_bloc.dart';
import 'package:pokedex/src/shared_widgets/pokemon_containers/pokemon_list_view.dart';

class AllPokemonScreen extends StatefulWidget {
  const AllPokemonScreen({Key? key}) : super(key: key);

  @override
  CustomState<AllPokemonScreen, AllPokemonBloc> createState() => _AllPokemonScreenState();
}

class _AllPokemonScreenState extends CustomState<AllPokemonScreen, AllPokemonBloc> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    _scrollController.addListener(() async {
      if (_scrollController.position.atEdge) {
        bool isBottom = _scrollController.position.pixels != 0 && !bloc.isLoadingBlocked;
        if (isBottom) {
          bloc.loadMore();
        }
      }
    });

    super.initState();
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return StreamBuilder<List<Results>?>(
        initialData: bloc.pokemonResult,
        stream: bloc.pokemonController.stream,
        builder: (context, snapshot) {
          return snapshot.data != null && snapshot.data!.isNotEmpty
              ? PokemonListView(
                  onTap: (index) {
                    Navigator.pushNamed(context, RouteConstants.pokemonDetails,
                        arguments: {AppConstants.singlePokemonModel: snapshot.data![index]});
                  },
                  scrollController: _scrollController,
                  results: snapshot.data,
                )
              : const Center(
                  child: CircularProgressIndicator(
                  color: ColorConstants.color_0xff3558CD,
                ));
        });
  }

  @override
  void onStart() async {
    bloc.startSubscription();
  }

  @override
  bool get wantKeepAlive => true;
}
