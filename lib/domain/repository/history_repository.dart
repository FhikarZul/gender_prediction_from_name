import 'package:dartz/dartz.dart';

abstract class IHistoryRepository {
  Future<Either<Exception, bool>> setHistory({
    required String id,
    required String name,
    required DateTime dateTime,
  });

  Future<Either<Exception, bool>> synced();
}
