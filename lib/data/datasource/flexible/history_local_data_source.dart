import 'package:gender_prediction/data/datasource/flexible/app_config.dart';
import 'package:gender_prediction/data/datasource/flexible/dao/history.dart';
import 'package:gender_prediction/data/model/history_model.dart';
import 'package:realm/realm.dart';

abstract class IHistoryLocalDataSource {
  Future<void> synced({
    required User user,
  });

  Future<void> setHistory({
    required String id,
    required String nameSearched,
    required DateTime dateTime,
    required User user,
  });

  Future<List<HistoryModel>> getHistory({required User user});
}

class HistoryLocalDataSource extends IHistoryLocalDataSource {
  final AppConfig appConfig;

  HistoryLocalDataSource({required this.appConfig});

  @override
  Future<void> setHistory({
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
    } catch (e) {
      throw Exception('failed to add history [$e]');
    }
  }

  @override
  Future<void> synced({
    required User user,
  }) async {
    try {
      final realm = await appConfig.getRealmInstance(user: user);
      const name = 'history';
      final allHistory = realm.all<History>();

      realm.subscriptions.update((mutableSubscriptions) {
        if (mutableSubscriptions.any((element) => element.name == name)) {
          return;
        }

        mutableSubscriptions.add(allHistory, name: name);
      });

      await realm.subscriptions.waitForSynchronization();
    } catch (e) {
      throw Exception('failed to synchronization [$e]');
    }
  }

  @override
  Future<List<HistoryModel>> getHistory({required User user}) async {
    try {
      final realm = await appConfig.getRealmInstance(user: user);

      final result = realm.all<History>();

      return result
          .map((e) => HistoryModel(
                id: e.id,
                dateTime: e.dateTime,
                nameSearched: e.nameSearched,
                uuidUser: e.uuidUser,
              ))
          .toList();
    } catch (e) {
      throw (Exception('failed to get history [$e]'));
    }
  }
}
