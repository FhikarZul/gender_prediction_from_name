import 'package:dartz/dartz.dart';
import 'package:gender_prediction/domain/repository/history_repository.dart';
import 'package:realm/realm.dart';

class InsertHistoryUseCase {
  final IHistoryRepository repository;

  InsertHistoryUseCase({required this.repository});

  Future<Either<Exception, bool>> execute({
    required String name,
  }) =>
      repository.setHistory(
        id: Uuid.v4().toString(),
        name: name,
        dateTime: DateTime.now(),
      );
}
