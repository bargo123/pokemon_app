import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/src/core/database/db_operations.dart';
import 'package:pokedex/src/core/database/object_box.dart';
import 'package:pokedex/src/core/repository/http_repo.dart';
import 'package:pokedex/src/core/utils/custom_textstyle.dart';
import 'package:pokedex/src/core/utils/formatters.dart';
import 'package:pokedex/src/core/utils/theme_manager.dart';
import 'package:pokedex/src/screens/all_pokemons/all_pokemon_bloc.dart';
import 'package:pokedex/src/screens/container/container_bloc.dart';
import 'package:pokedex/src/screens/favourites/favourites_bloc.dart';
import 'package:pokedex/src/screens/pokemon_details/pokemon_details_bloc.dart';
import 'package:pokedex/src/services/data/get_pokemons_data.dart';
import 'package:pokedex/src/services/general/networking_service.dart';

GetIt locator = GetIt.instance;
Future<void> setupLocator() async {
  locator.registerSingleton(Formatter());
  locator.registerSingleton(CustomTextStyle());
  locator.registerSingleton(ThemeManager());
  locator.registerSingleton(NetworkInfoService());
  locator.registerSingleton(DbOperations(await ObjectBox.create()));
  locator.registerSingleton(Dio());
  locator.registerSingleton(HttpRepo());
  locator.registerSingleton(GetPokemonData());
  locator.registerSingleton(ContainerBloc());
  locator.registerSingleton(AllPokemonBloc());
  locator.registerSingleton(FavouritesBloc());
  locator.registerFactory<PokemonDetailsBloc>(() => PokemonDetailsBloc());
}
