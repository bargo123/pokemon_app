// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'src/models/all_pokemon_model.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 4297215150385125483),
      name: 'Results',
      lastPropertyId: const IdUid(3, 8197679655377101725),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(id: const IdUid(1, 6383658480416610296), name: 'id', type: 6, flags: 129),
        ModelProperty(
            id: const IdUid(2, 9211885053051066742),
            name: 'name',
            type: 9,
            flags: 2080,
            indexId: const IdUid(2, 1274399755527786427)),
        ModelProperty(id: const IdUid(3, 8197679655377101725), name: 'url', type: 9, flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(1, 4297215150385125483),
      lastIndexId: const IdUid(2, 1274399755527786427),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [1947420399286034420],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    Results: EntityDefinition<Results>(
        model: _entities[0],
        toOneRelations: (Results object) => [],
        toManyRelations: (Results object) => {},
        getId: (Results object) => object.id,
        setId: (Results object, int id) {
          object.id = id;
        },
        objectToFB: (Results object, fb.Builder fbb) {
          final nameOffset = object.name == null ? null : fbb.writeString(object.name!);
          final urlOffset = object.url == null ? null : fbb.writeString(object.url!);
          fbb.startTable(4);
          fbb.addInt64(0, object.id ?? 0);
          fbb.addOffset(1, nameOffset);
          fbb.addOffset(2, urlOffset);
          fbb.finish(fbb.endTable());
          return object.id ?? 0;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Results(
              name: const fb.StringReader(asciiOptimization: true).vTableGetNullable(buffer, rootOffset, 6),
              url: const fb.StringReader(asciiOptimization: true).vTableGetNullable(buffer, rootOffset, 8),
              id: const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 4));

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [Results] entity fields to define ObjectBox queries.
class Results_ {
  /// see [Results.id]
  static final id = QueryIntegerProperty<Results>(_entities[0].properties[0]);

  /// see [Results.name]
  static final name = QueryStringProperty<Results>(_entities[0].properties[1]);

  /// see [Results.url]
  static final url = QueryStringProperty<Results>(_entities[0].properties[2]);
}
