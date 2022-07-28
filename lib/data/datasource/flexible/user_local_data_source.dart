import 'package:gender_prediction/data/datasource/flexible/app_config.dart';
import 'package:realm/realm.dart';

abstract class IUserLocalDataSource {
  Future<User?> login();
}

class UserLocalDataSource extends IUserLocalDataSource {
  final AppConfig appConfig;

  UserLocalDataSource({required this.appConfig});

  @override
  Future<User?> login() async {
    try {
      final app = App(appConfig.appConfiguration);
      User user = await app.logIn(Credentials.anonymous());

      return user;
    } catch (e) {
      throw Exception('authentication is failed');
    }
  }
}
