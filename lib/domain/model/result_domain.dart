import 'package:equatable/equatable.dart';

class ResultDomain extends Equatable {
  final String name;
  final String gender;

  const ResultDomain({
    required this.name,
    required this.gender
  });

  @override
  List<Object?> get props => [
        name,
        gender,
      ];
}
