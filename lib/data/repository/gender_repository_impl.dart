import 'package:gender_prediction/data/datasource/remote/gender_remote_data_source.dart';
import 'package:gender_prediction/domain/model/result_domain.dart';
import 'package:dartz/dartz.dart';
import 'package:gender_prediction/domain/repository/gender_repository.dart';

class GenderRepository extends IGenderRepository {
  final IGenderRemoteDataSource remoteDataSource;

  GenderRepository({required this.remoteDataSource});

  @override
  Future<Either<Exception, ResultDomain>> checkGender({
    required String name,
  }) async {
    try {
      final result = await remoteDataSource.checkGender(name: name);

      return Right(result.toDomain());
    } catch (e) {
      return Left(Exception('gender repository [$e]'));
    }
  }
}
