// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class History extends _History with RealmEntity, RealmObject {
  History(
    String id,
    String nameSearched,
    String uuidUser,
    DateTime dateTime,
  ) {
    RealmObject.set(this, '_id', id);
    RealmObject.set(this, 'name_searched', nameSearched);
    RealmObject.set(this, 'uuid_user', uuidUser);
    RealmObject.set(this, 'datetime', dateTime);
  }

  History._();

  @override
  String get id => RealmObject.get<String>(this, '_id') as String;
  @override
  set id(String value) => throw RealmUnsupportedSetError();

  @override
  String get nameSearched =>
      RealmObject.get<String>(this, 'name_searched') as String;
  @override
  set nameSearched(String value) =>
      RealmObject.set(this, 'name_searched', value);

  @override
  String get uuidUser => RealmObject.get<String>(this, 'uuid_user') as String;
  @override
  set uuidUser(String value) => RealmObject.set(this, 'uuid_user', value);

  @override
  DateTime get dateTime =>
      RealmObject.get<DateTime>(this, 'datetime') as DateTime;
  @override
  set dateTime(DateTime value) => RealmObject.set(this, 'datetime', value);

  @override
  Stream<RealmObjectChanges<History>> get changes =>
      RealmObject.getChanges<History>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(History._);
    return const SchemaObject(History, 'history', [
      SchemaProperty('_id', RealmPropertyType.string,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('name_searched', RealmPropertyType.string,
          mapTo: 'name_searched'),
      SchemaProperty('uuid_user', RealmPropertyType.string, mapTo: 'uuid_user'),
      SchemaProperty('datetime', RealmPropertyType.timestamp,
          mapTo: 'datetime'),
    ]);
  }
}
