import 'package:objectbox/objectbox.dart';
import 'package:pokedex/src/models/single_pokemon_model.dart';

class PokemonModel {
  int? count;
  String? next;
  String? previous;
  List<Results>? results;

  PokemonModel({this.count, this.next, this.previous, this.results});

  PokemonModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['next'] = next;
    data['previous'] = previous;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

@Entity()
class Results {
  @Id(assignable: true)
  int? id;
  @Unique()
  String? name;
  String? url;
  @Transient()
  SinglePokemonModel? pokemonDetails;
  Results({this.name, this.url, this.pokemonDetails, this.id});

  Results.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['url'] = url;
    return data;
  }
}
