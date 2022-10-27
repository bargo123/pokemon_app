import '../../models/single_pokemon_model.dart';

class Formatter {
  String idFormatter(int id) {
    String holder = "$id";
    while (holder.length < 3) {
      holder = "0$holder";
    }
    return "#$holder";
  }

  String pokemonTypesFormatter(List<Types> pokemonType) {
    String types = "";
    for (int typeIndex = 0; typeIndex < pokemonType.length; typeIndex++) {
      types +=
          "${pokemonType[typeIndex].type?.name}${pokemonType.length != 1 && (pokemonType.length - 1) != typeIndex ? ", " : ""}";
    }
    return types;
  }
}
