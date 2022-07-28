part of 'check_gender_bloc.dart';

class CheckGenderState extends Equatable {
  final String name;
  final bool isValidInput;
  final bool isValidGender;
  final bool isSuccess;
  final bool isLoading;
  final String resultGender;

  const CheckGenderState({
    required this.name,
    required this.isSuccess,
    required this.isValidGender,
    required this.isLoading,
    required this.isValidInput,
    required this.resultGender,
  });

  const CheckGenderState.initial()
      : name = '',
        isValidGender = true,
        isValidInput = true,
        isSuccess = false,
        isLoading = false,
        resultGender = '';

  CheckGenderState copyWith({
    String? name,
    bool? isSuccess,
    bool? isLoading,
    bool? isValidInput,
    String? resultGender,
    bool? isValidGender,
  }) =>
      CheckGenderState(
        name: name ?? this.name,
        isSuccess: isSuccess ?? this.isSuccess,
        isLoading: isLoading ?? this.isLoading,
        isValidInput: isValidInput ?? this.isValidInput,
        resultGender: resultGender ?? this.resultGender,
        isValidGender: isValidGender ?? this.isValidGender,
      );

  @override
  List<Object> get props => [
        name,
        isSuccess,
        isLoading,
        resultGender,
        isValidInput,
        isValidGender,
      ];
}
