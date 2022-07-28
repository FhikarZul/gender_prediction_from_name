import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gender_prediction/domain/usercase/check_gender_usecase.dart';
import 'package:gender_prediction/domain/usercase/insert_history_usecase.dart';
import 'package:gender_prediction/domain/usercase/sync_usecase.dart';

part 'check_gender_event.dart';
part 'check_gender_state.dart';

class CheckGenderBloc extends Bloc<CheckGenderEvent, CheckGenderState> {
  final CheckGenderUseCase checkGenderUseCase;
  final SyncUseCase syncUseCase;
  final InsertHistoryUseCase insertHistoryUseCase;

  CheckGenderBloc({
    required this.checkGenderUseCase,
    required this.syncUseCase,
    required this.insertHistoryUseCase,
  }) : super(const CheckGenderState.initial()) {
    on<CheckGenderEventInitial>((event, emit) async {
      final resultSync = await syncUseCase.execute();

      resultSync.fold(
        (exception) => print(exception),
        (result) => print('is sync'),
      );
    });

    on<CheckGenderEventInput>((event, emit) {
      if (event.name.isEmpty) {
        emit(state.copyWith(isValidInput: false));
        return;
      }

      emit(state.copyWith(
        name: event.name,
        isValidInput: true,
        isInitial: true,
      ));
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

      final resultInsertLocal = await insertHistoryUseCase.execute(
        name: state.name,
      );

      resultInsertLocal.fold(
        (exception) => print(exception),
        (result) => print('insert to local is success'),
      );
    });
  }
}
