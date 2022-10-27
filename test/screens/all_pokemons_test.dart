// @dart=2.9
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex/locator.dart';
import 'package:pokedex/src/models/all_pokemon_model.dart';
import 'package:pokedex/src/models/single_pokemon_model.dart';
import 'package:pokedex/src/screens/all_pokemons/all_pokemon_bloc.dart';
import 'package:pokedex/src/services/data/get_pokemons_data.dart';
import 'package:pokedex/src/services/general/networking_service.dart';

import '../fixtures.dart';

class MockAllPokemonService extends Mock implements GetPokemonData {}

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() async {
    // ignore: await_only_futures
    await basicMockService();
    locator.registerSingleton<GetPokemonData>(MockAllPokemonService());
    when(locator<NetworkInfoService>().isAvailable()).thenAnswer((realInvocation) async => true);
  });

  test("Get All Pokemons", () async {
    AllPokemonBloc bloc = AllPokemonBloc();
    when(locator<GetPokemonData>().getPokemonData())
        .thenAnswer((realInvocation) => Future.value(PokemonModel(count: 20, results: [Results(name: "bulb")])));
    when(locator<GetPokemonData>().getPokemonSprites("bulb"))
        .thenAnswer((realInvocation) => Future.value(SinglePokemonModel(id: 1, height: 10, weight: 20)));
    var pokemonData = await bloc.getAllPokemonDetails();
    expect(pokemonData.results.first.id, 1);
    expect(pokemonData.results.first.pokemonDetails.height, 10);
  });

  test("update page offset", () async {
    AllPokemonBloc bloc = AllPokemonBloc();
    expect(bloc.pageOffset, 0);
    bloc.updateOffset();
    expect(bloc.pageOffset, 20);
  });
}
