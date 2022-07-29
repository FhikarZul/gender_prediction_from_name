import 'package:dartz/dartz.dart';
import 'package:gender_prediction/domain/model/populer_name_domain.dart';

abstract class IHistoryRepository {
  Future<Either<Exception, bool>> setHistory({
    required String id,
    required String name,
    required DateTime dateTime,
  });

  Future<Either<Exception, bool>> synced();

  Future<Either<Exception, List<PopulerNameDomain>>> getNamePopuler();
}
