import 'dart:async';

import 'package:pokedex/locator.dart';
import 'package:pokedex/src/core/utils/bloc_life_cycle.dart';

import '../../models/all_pokemon_model.dart';
import '../../services/data/get_pokemons_data.dart';

class FavouritesBloc with BlocLifeCycleInterface {
  final StreamController<List<Results>> pokemonController = StreamController<List<Results>>.broadcast();

  final StreamController<String> buttonController = StreamController<String>.broadcast();
  final GetPokemonData _pokemonService = locator<GetPokemonData>();
  final List<Results> _result = [];

  @override
  void startSubscription({List? arguments}) async {
    await getAllPokemons();
    _pokemonService.addPokemonController.stream.listen((event) async {
      var favouritePokemons = _pokemonService.getPokemon(event);
      var updatedData = await _pokemonService.getPokemonSprites(favouritePokemons?.name ?? "");
      _result.add(Results(name: favouritePokemons?.name ?? "", pokemonDetails: updatedData, id: favouritePokemons?.id));
      pokemonController.sink.add(_result);
    });

    _pokemonService.removePokemonController.stream.listen((event) {
      _result.removeWhere((element) => element.id == event);
      pokemonController.sink.add(_result);
    });
  }

  Future getAllPokemons() async {
    _result.clear();
    var favouritePokemons = _pokemonService.getAllPokemons() ?? [];
    for (var pokemon in favouritePokemons) {
      var updatedData = await _pokemonService.getPokemonSprites(pokemon.name ?? "");
      _result.add(Results(name: pokemon.name ?? "", pokemonDetails: updatedData, id: pokemon.id));
    }

    pokemonController.sink.add(_result);
  }

  List<Results> get pokemonResult => _result;
}
