import 'package:flutter/material.dart';
import 'package:pokedex/src/core/constants/color_constants.dart';

class SinglePokemonModel {
  Sprites? sprites;
  List<Types>? types;
  int? id;
  List<Stats>? stats;
  int? height;
  int? weight;
  Color? color;

  SinglePokemonModel({this.sprites, this.types, this.id, this.stats, this.height, this.weight});

  SinglePokemonModel.fromJson(Map<String, dynamic> json) {
    sprites = json['sprites'] != null ? Sprites.fromJson(json['sprites']) : null;
    if (json['types'] != null) {
      types = <Types>[];
      json['types'].forEach((v) {
        types!.add(Types.fromJson(v));
      });
      color = getPokemonColor(types!.first.type?.name ?? "");
    }
    id = json['id'];
    if (json['stats'] != null) {
      stats = <Stats>[];
      json['stats'].forEach((v) {
        stats!.add(Stats.fromJson(v));
      });
    }
    height = json['height'];
    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sprites != null) {
      data['sprites'] = sprites!.toJson();
    }
    if (types != null) {
      data['types'] = types!.map((v) => v.toJson()).toList();
    }
    data['id'] = id;
    if (stats != null) {
      data['stats'] = stats!.map((v) => v.toJson()).toList();
    }
    data['height'] = height;
    data['weight'] = weight;
    return data;
  }

  Color getPokemonColor(String type) {
    switch (type) {
      case "grass":
        return ColorConstants.color_0xffF3F9EF;
      case "water":
        return ColorConstants.color_0xffF3F9FE;
      case "fire":
        return ColorConstants.color_0xffFDF1F1;
      case "poison":
        return Colors.purple.withOpacity(0.6);
      case "electric":
        return Colors.yellowAccent.withOpacity(0.6);
      case "fairy":
        return Colors.pinkAccent.withOpacity(0.6);
      case "ghost":
        return Colors.deepPurple.withOpacity(0.6);
      default:
        return Colors.grey.withOpacity(0.6);
    }
  }
}

class Sprites {
  Other? other;

  Sprites({this.other});

  Sprites.fromJson(Map<String, dynamic> json) {
    other = json['other'] != null ? Other.fromJson(json['other']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (other != null) {
      data['other'] = other!.toJson();
    }
    return data;
  }
}

class Other {
  OfficialArtwork? officialArtwork;

  Other({this.officialArtwork});

  Other.fromJson(Map<String, dynamic> json) {
    officialArtwork = json['official-artwork'] != null ? OfficialArtwork.fromJson(json['official-artwork']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (officialArtwork != null) {
      data['official-artwork'] = officialArtwork!.toJson();
    }
    return data;
  }
}

class OfficialArtwork {
  String? frontDefault;

  OfficialArtwork({this.frontDefault});

  OfficialArtwork.fromJson(Map<String, dynamic> json) {
    frontDefault = json['front_default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['front_default'] = frontDefault;
    return data;
  }
}

class Types {
  Type? type;

  Types({this.type});

  Types.fromJson(Map<String, dynamic> json) {
    type = json['type'] != null ? Type.fromJson(json['type']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (type != null) {
      data['type'] = type!.toJson();
    }
    return data;
  }
}

class Type {
  String? name;
  String? url;

  Type({this.name, this.url});

  Type.fromJson(Map<String, dynamic> json) {
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

class Stats {
  num? baseStat;

  int? effort;
  Type? stat;

  Stats({this.baseStat, this.effort, this.stat});

  Stats.fromJson(Map<String, dynamic> json) {
    baseStat = json['base_stat'];
    effort = json['effort'];
    stat = json['stat'] != null ? Type.fromJson(json['stat']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['base_stat'] = baseStat;
    data['effort'] = effort;
    if (stat != null) {
      data['stat'] = stat!.toJson();
    }
    return data;
  }
}
