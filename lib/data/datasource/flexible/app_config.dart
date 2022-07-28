import 'package:gender_prediction/data/datasource/flexible/dao/history.dart';
import 'package:realm/realm.dart';

const appId = 'genderprediction-yzmnr';

class AppConfig {
  AppConfiguration appConfiguration = AppConfiguration(
    appId,
    defaultRequestTimeout: const Duration(seconds: 120),
    localAppVersion: '2.0',
  );

  Future<Realm> getRealmInstance({required User? user}) async {
    if (user == null) {
      throw Exception();
    }

    final configuration = Configuration.flexibleSync(user, [History.schema]);

    return Realm(configuration);
  }
}
