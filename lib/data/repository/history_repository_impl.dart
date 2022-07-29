import 'package:dartz/dartz.dart';
import 'package:gender_prediction/data/datasource/flexible/history_local_data_source.dart';
import 'package:gender_prediction/data/datasource/flexible/user_local_data_source.dart';
import 'package:gender_prediction/domain/model/populer_name_domain.dart';
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

  @override
  Future<Either<Exception, List<PopulerNameDomain>>> getNamePopuler() async {
    List<PopulerNameDomain> populerName = [];

    try {
      final user = await userLocalDataSource.login();

      if (user == null) {
        return Left(Exception('failed to login'));
      }

      final result = await historyLocalDataSource.getHistory(user: user);

      final map = result.map((e) => e).toList().asMap();

      for (var val in map.entries) {
        int count = map.entries
            .where(
              (element) =>
                  element.value.nameSearched.toLowerCase() ==
                  val.value.nameSearched.toLowerCase(),
            )
            .toList()
            .length;

        populerName.removeWhere(
          (element) =>
              element.name.toLowerCase() ==
              val.value.nameSearched.toLowerCase(),
        );

        populerName.add(PopulerNameDomain(
          name: val.value.nameSearched,
          count: count,
        ));
      }

      populerName.sort((a, b) => b.count.compareTo(a.count));

      return Right(populerName);
    } catch (e) {
      return Left(Exception('get history repository is error [$e]'));
    }
  }
}
