import 'dart:async';

import 'package:pokedex/src/core/utils/bloc_life_cycle.dart';
import 'package:pokedex/src/models/all_pokemon_model.dart';
import 'package:pokedex/src/services/data/get_pokemons_data.dart';

import '../../../locator.dart';

class AllPokemonBloc implements BlocLifeCycleInterface {
  StreamController<List<Results>> pokemonController = StreamController<List<Results>>.broadcast();
  final GetPokemonData _pokemonService = locator<GetPokemonData>();
  final List<Results> _result = [];
  bool isLoadingBlocked = false;
  int _pgOffset = 0;

  @override
  void pauseSubscription({List? arguments}) {}

  @override
  void resumeSubscription({List? arguments}) {}

  @override
  void startSubscription({List? arguments}) async {
    await flitterPokemons();
  }

  @override
  void stopSubscription({List? arguments}) {}
  Future<PokemonModel?> getAllPokemonDetails() async {
    var pokemonModel = await _pokemonService.getPokemonData(offset: _pgOffset);
    for (int index = 0; index < (pokemonModel?.results?.length ?? 0); index++) {
      var name = pokemonModel?.results?[index].name;
      var sprite = await _pokemonService.getPokemonSprites(name!);
      pokemonModel?.results?[index].pokemonDetails = sprite;
      pokemonModel?.results?[index].id = sprite.id;
    }
    return pokemonModel!;
  }

  Future loadMore() async {
    isLoadingBlocked = true;
    updateOffset();
    await flitterPokemons();
    isLoadingBlocked = false;
  }

  Future flitterPokemons() async {
    var pokemonModel = await getAllPokemonDetails();
    pokemonModel?.results?.forEach((element) {
      _result.add(element);
    });
    if (pokemonModel != null) {
      pokemonController.sink.add(_result);
    }
  }

  void updateOffset() {
    _pgOffset += 20;
  }

  int get pageOffset => _pgOffset;

  List<Results> get pokemonResult => _result;
}
