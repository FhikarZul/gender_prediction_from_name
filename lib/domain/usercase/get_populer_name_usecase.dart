import 'package:dartz/dartz.dart';
import 'package:gender_prediction/data/datasource/flexible/history_local_data_source.dart';
import 'package:gender_prediction/domain/model/populer_name_domain.dart';
import 'package:gender_prediction/domain/repository/history_repository.dart';

class GetPopulerNameUseCase {
  final IHistoryRepository repository;

  GetPopulerNameUseCase({required this.repository});

  Future<Either<Exception, List<PopulerNameDomain>>> execute() =>
      repository.getNamePopuler();
}
