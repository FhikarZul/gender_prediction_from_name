import 'package:dartz/dartz.dart';
import 'package:gender_prediction/data/datasource/flexible/history_local_data_source.dart';
import 'package:gender_prediction/data/datasource/flexible/user_local_data_source.dart';
import 'package:gender_prediction/domain/repository/history_repository.dart';

class HistoryRepositoryImpl extends IHistoryRepository {
  final IHistoryLocalDataSource historyLocalDataSource;
  final IUserLocalDataSource userLocalDataSource;

  HistoryRepositoryImpl({
    required this.historyLocalDataSource,
    required this.userLocalDataSource,
  });

  @override
  Future<Either<Exception, bool>> setHistory({
    required String id,
    required String name,
    required DateTime dateTime,
  }) async {
    final user = await userLocalDataSource.login();

    try {
      if (user == null) {
        return Left(Exception('failed to login'));
      }

      await historyLocalDataSource.setHistory(
        id: id,
        nameSearched: name,
        dateTime: dateTime,
        user: user,
      );

      return const Right(true);
    } catch (e) {
      return Left(Exception('history repository error [$e]'));
    }
  }

  @override
  Future<Either<Exception, bool>> synced() async {
    try {
      final user = await userLocalDataSource.login();

      if (user == null) {
        return Left(Exception('failed to login'));
      }

      await historyLocalDataSource.synced(user: user);

      return const Right(true);
    } catch (e) {
      return Left(Exception('sync is error [$e]'));
    }
  }
}
