part of 'populer_bloc.dart';

abstract class PopulerEvent extends Equatable {}

class PopulerEventIntial extends PopulerEvent {
  @override
  List<Object?> get props => [];
}

class PopulerEventSearch extends PopulerEvent {
  final String name;

  PopulerEventSearch({required this.name});

  @override
  List<Object?> get props => [name];
}
