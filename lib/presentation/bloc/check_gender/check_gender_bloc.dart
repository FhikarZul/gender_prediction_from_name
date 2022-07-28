import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gender_prediction/domain/usercase/check_gender_usecase.dart';

part 'check_gender_event.dart';
part 'check_gender_state.dart';

class CheckGenderBloc extends Bloc<CheckGenderEvent, CheckGenderState> {
  final CheckGenderUseCase checkGenderUseCase;

  CheckGenderBloc({
    required this.checkGenderUseCase,
  }) : super(const CheckGenderState.initial()) {
    on<CheckGenderEventInput>((event, emit) {
      emit(state.copyWith(name: event.name));
    });

    on<CheckGenderEventSubmit>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      final result = await checkGenderUseCase.execute(
        name: state.name,
      );

      result.fold(
        (exception) {
          emit(state.copyWith(
            isSuccess: false,
            isLoading: false,
            isValidGender: false,
          ));

          emit(state.copyWith(isValidGender: true));
        },
        (result) {
          emit(
            state.copyWith(
              isSuccess: true,
              resultGender: result.gender,
              isLoading: false,
            ),
          );
          emit(state.copyWith(isSuccess: false, isLoading: false));
        },
      );
    });
  }
}
