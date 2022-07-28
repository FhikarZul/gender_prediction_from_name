import 'package:dartz/dartz.dart';
import 'package:gender_prediction/domain/repository/history_repository.dart';

class SyncUseCase {
  final IHistoryRepository repository;
  SyncUseCase({
    required this.repository,
  });
  Future<Either<Exception, bool>> execute() => repository.synced();
}
