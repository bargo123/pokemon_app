// @dart=2.9
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex/locator.dart';
import 'package:pokedex/src/core/database/db_operations.dart';
import 'package:pokedex/src/models/all_pokemon_model.dart';
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

  test('get all pokemons', () async {
    final response = await fakeResponse({
      "count": 1,
      "results": [
        {"name": "bulb", "url": "https://pokeapi.co/api/v2/pokemon/1/"},
        {"name": "Pika", "url": "https://pokeapi.co/api/v2/pokemon/1/"},
        {"name": "Char", "url": "https://pokeapi.co/api/v2/pokemon/1/"},
      ]
    });

    when(callDio()).thenAnswer((_) => Future.value(response));

    var data = await GetPokemonData().getPokemonData();
    final request = verifyDioHaveBeenCalled(capturedIndex: 0);
    expect(data.results.length, 3);
    expect(request.path, 'pokemon');
  });

  test('get Single pokemons', () async {
    final response = await fakeResponse({"id": 1});
    when(callDio()).thenAnswer((_) => Future.value(response));
    var data = await GetPokemonData().getPokemonSprites("Bulbasur");
    final request = verifyDioHaveBeenCalled(capturedIndex: 0);
    expect(data.id, 1);
    expect(request.path, 'pokemon/Bulbasur');
  });

  test('contains Pokemon', () async {
    when(locator<DbOperations>().contains(1)).thenAnswer((realInvocation) => true);
    var data = GetPokemonData().containsPokemon(1);
    expect(data, true);
  });
  test('put pokemon', () async {
    when(locator<DbOperations>().putData<Results>(any)).thenAnswer((realInvocation) => 1);
    GetPokemonData().storePokemon(Results(id: 1, name: "pika"));
    verify(locator<DbOperations>().putData(any)).called(1);
  });
  test('count pokemon', () async {
    GetPokemonData object = GetPokemonData();
    object.favouritesCounterController.stream.listen((event) {
      expect(event, 20);
    });
    when(locator<DbOperations>().count()).thenAnswer((realInvocation) => 20);
    object.pokemonsInFavourites();
  });
  test('get All Pokemon From DB', () async {
    when(locator<DbOperations>().getAll<Results>()).thenAnswer((realInvocation) => [Results(id: 1, name: "bulb")]);
    var data = GetPokemonData().getAllPokemons();
    expect(data.first.name, "bulb");
  });
  test('remove Pokemon', () async {
    when(locator<DbOperations>().remove(1)).thenAnswer((realInvocation) => true);
    GetPokemonData().removePokemon(1);
    verify(locator<DbOperations>().remove(1)).called(1);
  });
}
