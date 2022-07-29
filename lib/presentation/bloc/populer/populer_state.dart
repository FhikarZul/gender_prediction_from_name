part of 'populer_bloc.dart';

class PopulerState extends Equatable {
  final List<PopulerNameDomain> populerNames;

  const PopulerState({required this.populerNames});

  PopulerState.initial() : populerNames = [];

  @override
  List<Object> get props => [populerNames];
}
