import 'package:dartz/dartz.dart';
import 'package:gender_prediction/domain/model/result_domain.dart';

abstract class IGenderRepository {
  Future<Either<Exception, ResultDomain>> checkGender({required String name});
}
