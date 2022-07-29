import 'package:gender_prediction/data/datasource/flexible/app_config.dart';
import 'package:gender_prediction/data/datasource/flexible/history_local_data_source.dart';
import 'package:gender_prediction/data/datasource/flexible/user_local_data_source.dart';
import 'package:gender_prediction/data/datasource/remote/gender_remote_data_source.dart';
import 'package:gender_prediction/data/repository/gender_repository_impl.dart';
import 'package:gender_prediction/data/repository/history_repository_impl.dart';
import 'package:gender_prediction/domain/repository/gender_repository.dart';
import 'package:gender_prediction/domain/repository/history_repository.dart';
import 'package:gender_prediction/domain/usercase/check_gender_usecase.dart';
import 'package:gender_prediction/domain/usercase/get_populer_name_usecase.dart';
import 'package:gender_prediction/domain/usercase/insert_history_usecase.dart';
import 'package:gender_prediction/domain/usercase/sync_usecase.dart';
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
    GenderRepositoryImpl(remoteDataSource: locator.get()),
  );
  locator.registerSingleton<IHistoryRepository>(
    HistoryRepositoryImpl(
        historyLocalDataSource: locator.get(),
        userLocalDataSource: locator.get()),
  );

  //use case
  locator.registerFactory(() => CheckGenderUseCase(repository: locator.get()));
  locator.registerFactory(() => SyncUseCase(repository: locator.get()));
  locator.registerFactory(
    () => InsertHistoryUseCase(repository: locator.get()),
  );
  locator.registerFactory(
    () => GetPopulerNameUseCase(repository: locator.get()),
  );
}
