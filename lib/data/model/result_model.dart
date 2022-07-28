import 'package:equatable/equatable.dart';
import 'package:gender_prediction/domain/model/result_domain.dart';

class ResultModel extends Equatable {
  final String name;
  final String gender;
  final double probability;
  final int count;

  const ResultModel({
    required this.name,
    required this.gender,
    required this.probability,
    required this.count,
  });

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
        name: json['name'],
        gender: json['gender'],
        probability: json['probability'],
        count: json['count'],
      );

  ResultDomain toDomain() => ResultDomain(
        name: name,
        gender: gender,
      );

  @override
  List<Object?> get props => [
        name,
        gender,
        probability,
        count,
      ];
}
