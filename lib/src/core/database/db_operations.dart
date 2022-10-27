import 'package:pokedex/src/core/database/object_box.dart';
import 'package:pokedex/src/core/errors/exceptions.dart';

class DbOperations {
  DbOperations(this.objectBox);
  final ObjectBox objectBox;

  int putData<T>(T results) {
    try {
      final pokResults = objectBox.store.box<T>();
      return pokResults.put(results);
    } catch (e) {
      throw DataBaseException("Database operation went wrong");
    }
  }

  List<T> getAll<T>() {
    try {
      final pokResults = objectBox.store.box<T>();
      return pokResults.getAll();
    } catch (e) {
      throw DataBaseException("Database operation went wrong");
    }
  }

  T? getOne<T>(int id) {
    try {
      final pokResults = objectBox.store.box<T>();
      return pokResults.get(id);
    } catch (e) {
      throw DataBaseException("Database operation went wrong");
    }
  }

  int count<T>() {
    try {
      final pokResults = objectBox.store.box<T>();
      return pokResults.count(limit: 0);
    } catch (e) {
      throw DataBaseException("Database operation went wrong");
    }
  }

  void remove<T>(int? id) {
    if (id == null) return;
    try {
      final pokResults = objectBox.store.box<T>();
      pokResults.remove(id);
    } catch (e) {
      throw DataBaseException("Database operation went wrong");
    }
  }

  bool? contains<T>(int? id) {
    try {
      final pokResults = objectBox.store.box<T>();
      return pokResults.contains(id!);
    } catch (e) {
      throw DataBaseException("Database operation went wrong");
    }
  }
}
