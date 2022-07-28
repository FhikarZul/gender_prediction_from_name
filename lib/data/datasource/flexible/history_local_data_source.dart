import 'package:gender_prediction/data/datasource/flexible/app_config.dart';
import 'package:gender_prediction/data/datasource/flexible/dao/history.dart';
import 'package:realm/realm.dart';

abstract class IHistoryLocalDataSource {
  Future<void> synced(
    RealmResults query, {
    required String name,
    required User user,
  });
  Future<void> setHistory({
    required String id,
    required String nameSearched,
    required DateTime dateTime,
    required User user,
  });
}

class HistoryLocalDataSource extends IHistoryLocalDataSource {
  final AppConfig appConfig;

  HistoryLocalDataSource({required this.appConfig});

  @override
  Future<String> setHistory({
    required String id,
    required String nameSearched,
    required DateTime dateTime,
    required User user,
  }) async {
    try {
      final realm = await appConfig.getRealmInstance(user: user);

      final history = History(
        id,
        nameSearched,
        user.id,
        dateTime,
      );

      realm.write(() => realm.add(history));

      return 'add history success.';
    } catch (e) {
      throw Exception('failed to add history [$e]');
    }
  }

  @override
  Future<void> synced(
    RealmResults<RealmObject> query, {
    required String name,
    required User user,
  }) async {
    try {
      final realm = await appConfig.getRealmInstance(user: user);

      realm.subscriptions.update((mutableSubscriptions) {
        if (mutableSubscriptions.any((element) => element.name == name)) {
          return;
        }

        mutableSubscriptions.add(query, name: name);
      });

      await realm.subscriptions.waitForSynchronization();
    } catch (e) {
      throw Exception('failed to synchronization [$e]');
    }
  }
}
