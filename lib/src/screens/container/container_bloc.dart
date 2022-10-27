import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokedex/locator.dart';
import 'package:pokedex/src/core/utils/bloc_life_cycle.dart';
import 'package:pokedex/src/services/data/get_pokemons_data.dart';

class ContainerBloc with BlocLifeCycleInterface {
  var image;
  StreamController<int> counterController = StreamController<int>.broadcast();

  int _counterValue = 0;

  @override
  void startSubscription({List? arguments}) {
    locator<GetPokemonData>().favouritesCounterController.stream.listen((event) {
      _counterValue = event;
      counterController.sink.add(_counterValue);
    });
    locator<GetPokemonData>().pokemonsInFavourites();
  }

  int get counter => _counterValue;
}
