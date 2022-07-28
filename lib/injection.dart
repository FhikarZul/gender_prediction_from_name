import 'package:gender_prediction/data/datasource/flexible/app_config.dart';
import 'package:gender_prediction/data/datasource/flexible/history_local_data_source.dart';
import 'package:gender_prediction/data/datasource/flexible/user_local_data_source.dart';
import 'package:gender_prediction/data/datasource/remote/gender_remote_data_source.dart';
import 'package:gender_prediction/data/repository/gender_repository_impl.dart';
import 'package:gender_prediction/domain/repository/gender_repository.dart';
import 'package:gender_prediction/domain/usercase/check_gender_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

final locator = GetIt.instance;

void initInjection() {
  //http client
  locator.registerLazySingleton<Client>(() => Client());

  //app config
  locator.registerSingleton<AppConfig>(AppConfig());

  //remote data source
  locator.registerSingleton<IGenderRemoteDataSource>(
    GenderRemoteDataSource(httpClient: locator.get()),
  );

  //local data source
  locator.registerSingleton<IUserLocalDataSource>(
    UserLocalDataSource(appConfig: locator.get()),
  );
  locator.registerSingleton<IHistoryLocalDataSource>(
    HistoryLocalDataSource(appConfig: locator.get()),
  );

  //repository
  locator.registerSingleton<IGenderRepository>(
    GenderRepository(remoteDataSource: locator.get()),
  );

  //use case
  locator.registerFactory(() => CheckGenderUseCase(repository: locator.get()));
}
