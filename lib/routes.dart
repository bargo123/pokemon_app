import 'package:flutter/material.dart';
import 'package:pokedex/src/core/constants/routes_constants.dart';
import 'package:pokedex/src/screens/container/container_screen.dart';

import 'src/screens/pokemon_details/pokemon_details_screen.dart';

// if there is
Map<String, WidgetBuilder> routes = {
  RouteConstants.pokemonDetails: ((context) => const PokemonDetails()),
  RouteConstants.container: ((context) => const ContainerScreen()),
};
