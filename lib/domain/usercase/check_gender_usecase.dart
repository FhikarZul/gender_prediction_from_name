import 'package:dartz/dartz.dart';
import 'package:gender_prediction/domain/model/result_domain.dart';
import 'package:gender_prediction/domain/repository/gender_repository.dart';

class CheckGenderUseCase {
  final IGenderRepository repository;

  CheckGenderUseCase({required this.repository});

  Future<Either<Exception, ResultDomain>> execute({required String name}) =>
      repository.checkGender(name: name);
}
