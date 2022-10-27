import 'dart:async';
import 'dart:ui';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:pokedex/locator.dart';
import 'package:pokedex/src/core/constants/color_constants.dart';
import 'package:pokedex/src/core/utils/bloc_life_cycle.dart';
import 'package:pokedex/src/models/all_pokemon_model.dart';
import 'package:pokedex/src/services/data/get_pokemons_data.dart';

class PokemonDetailsBloc with BlocLifeCycleInterface {
  Results pokemonResult = Results();
  StreamController<bool> favouritesStatusControllers = StreamController<bool>.broadcast();
  final Map<String, num?> _sortedBaseStats = {};
  Map<String, num?> sortBaseStats() {
    num avgPower = 0;
    for (int i = 0; i < pokemonResult.pokemonDetails!.stats!.length; i++) {
      switch (pokemonResult.pokemonDetails?.stats![i].stat!.name) {
        case "hp":
          var hpStat = pokemonResult.pokemonDetails?.stats![i].baseStat;
          avgPower += hpStat!;
          _sortedBaseStats.putIfAbsent("Hp", () => hpStat);
          break;
        case "attack":
          var hpStat = pokemonResult.pokemonDetails?.stats![i].baseStat;
          avgPower += hpStat!;
          _sortedBaseStats.putIfAbsent("Attack", () => hpStat);
          break;
        case "defense":
          var hpStat = pokemonResult.pokemonDetails?.stats![i].baseStat;
          avgPower += hpStat!;
          _sortedBaseStats.putIfAbsent("Defense", () => hpStat);
          break;
        case "special-attack":
          var hpStat = pokemonResult.pokemonDetails?.stats![i].baseStat;
          avgPower += hpStat!;
          _sortedBaseStats.putIfAbsent("Special Attack", () => hpStat);
          break;
        case "special-defense":
          var hpStat = pokemonResult.pokemonDetails?.stats![i].baseStat;
          avgPower += hpStat!;
          _sortedBaseStats.putIfAbsent("Special Defense", () => hpStat);
          break;
        case "speed":
          var hpStat = pokemonResult.pokemonDetails?.stats![i].baseStat;
          avgPower += hpStat!;
          _sortedBaseStats.putIfAbsent("Speed", () => hpStat);
          break;
        default:
      }
    }
    _sortedBaseStats.putIfAbsent("Avg. Power", () => num.parse((avgPower / 6).toStringAsFixed(4)));
    return _sortedBaseStats;
  }

  Color progressBarColors(num value) {
    var color = ColorConstants.color_0xffE8E8E8;
    if (value > 0 && value < 50) {
      color = ColorConstants.color_0xffCD2873;
    }
    if (value >= 50 && value < 75) {
      color = ColorConstants.color_0xffEEC218;
    }
    if (value >= 75) {
      color = ColorConstants.color_0xff5CFF5C;
    }
    return color;
  }

  Future<void> removeOrAddPokemonWatchList() async {
    EasyDebounce.debounce("debounce", const Duration(milliseconds: 200), () {
      if (_isPokemonAddedToFavourites() == false) {
        locator<GetPokemonData>().storePokemon(pokemonResult);
        favouritesStatusControllers.sink.add(true);
      } else {
        locator<GetPokemonData>().removePokemon(pokemonResult.id!);
        favouritesStatusControllers.sink.add(false);
      }
    });
  }

  bool? _isPokemonAddedToFavourites() {
    return locator<GetPokemonData>().containsPokemon(pokemonResult.id);
  }

  Map<String, num?> get statsGetter => _sortedBaseStats;

  @override
  void startSubscription({List? arguments}) {
    favouritesStatusControllers.sink.add(_isPokemonAddedToFavourites() ?? false);
  }
}
