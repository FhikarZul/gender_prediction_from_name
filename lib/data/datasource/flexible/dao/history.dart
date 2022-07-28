import 'package:realm/realm.dart';

part 'history.g.dart';

@RealmModel()
@MapTo('history')
class _History {
  @PrimaryKey()
  @MapTo('_id')
  late final String id;

  @MapTo('name_searched')
  late String nameSearched;
  @MapTo('uuid_user')
  late String uuidUser;
  @MapTo('datetime')
  late DateTime dateTime;
}
