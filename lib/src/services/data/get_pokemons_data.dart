import 'dart:async';

import 'package:pokedex/src/core/constants/api_constants.dart';
import 'package:pokedex/src/core/database/db_operations.dart';
import 'package:pokedex/src/core/repository/http_repo.dart';
import 'package:pokedex/src/enums/http_enum.dart';
import 'package:pokedex/src/models/all_pokemon_model.dart';
import 'package:pokedex/src/models/single_pokemon_model.dart';

import '../../../locator.dart';

class GetPokemonData {
  StreamController<int> addPokemonController = StreamController<int>.broadcast();
  StreamController<int> removePokemonController = StreamController<int>.broadcast();
  StreamController<int> favouritesCounterController = StreamController<int>.broadcast();

  Future<PokemonModel>? getPokemonData({int offset = 0}) async {
    var request = await locator<HttpRepo>()
        .makeRequest(requestType: HttpRequestEnum.GET, methodName: ApiConstants.pokemon, getQueryParam: {"offset": offset});
    return PokemonModel.fromJson(request);
  }

  Future<SinglePokemonModel> getPokemonSprites(String pokemonName) async {
    var request = await locator<HttpRepo>()
        .makeRequest(requestType: HttpRequestEnum.GET, methodName: "${ApiConstants.pokemon}/$pokemonName");
    return SinglePokemonModel.fromJson(request);
  }

  void storePokemon(Results results) {
    var id = locator<DbOperations>().putData<Results>(results);
    addPokemonController.sink.add(id);
    pokemonsInFavourites();
  }

  List<Results>? getAllPokemons() {
    return locator<DbOperations>().getAll<Results>();
  }

  void removePokemon(int id) {
    locator<DbOperations>().remove<Results>(id);
    removePokemonController.sink.add(id);
    pokemonsInFavourites();
  }

  bool? containsPokemon(int? id) {
    return locator<DbOperations>().contains<Results>(id);
  }

  Results? getPokemon(int? id) {
    return locator<DbOperations>().getOne<Results>(id!);
  }

  void pokemonsInFavourites() {
    int count = locator<DbOperations>().count<Results>();
    favouritesCounterController.sink.add(count);
  }
}
