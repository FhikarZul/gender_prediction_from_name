part of 'check_gender_bloc.dart';

abstract class CheckGenderEvent extends Equatable {}

class CheckGenderEventInitial extends CheckGenderEvent {
  @override
  List<Object?> get props => [];
}

class CheckGenderEventInput extends CheckGenderEvent {
  final String name;

  CheckGenderEventInput({required this.name});

  @override
  List<Object?> get props => [name];
}

class CheckGenderEventSubmit extends CheckGenderEvent {
  @override
  List<Object?> get props => [];
}
