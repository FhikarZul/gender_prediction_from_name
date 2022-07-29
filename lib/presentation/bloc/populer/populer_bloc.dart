import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gender_prediction/domain/model/populer_name_domain.dart';
import 'package:gender_prediction/domain/usercase/get_populer_name_usecase.dart';

part 'populer_event.dart';
part 'populer_state.dart';

class PopulerBloc extends Bloc<PopulerEvent, PopulerState> {
  final GetPopulerNameUseCase populerNameUseCase;

  PopulerBloc({required this.populerNameUseCase})
      : super(PopulerState.initial()) {
    on<PopulerEventIntial>((event, emit) async {
      add(PopulerEventSearch(name: ''));
    });

    on<PopulerEventSearch>((event, emit) async {
      final result = await populerNameUseCase.execute();
      result.fold(
        (exception) => print(exception),
        (result) {
          var data = result
              .where(
                (element) => element.name
                    .toLowerCase()
                    .contains(event.name.toLowerCase()),
              )
              .toList();
          emit(PopulerState(populerNames: data));
        },
      );
    });
  }
}
