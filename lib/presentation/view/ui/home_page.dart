import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gender_prediction/injection.dart';
import 'package:gender_prediction/presentation/bloc/check_gender/check_gender_bloc.dart';
import 'package:gender_prediction/presentation/view/ui/gender_not_found.dart';
import 'package:gender_prediction/presentation/view/ui/populer_page.dart';
import 'package:gender_prediction/presentation/view/ui/result_page.dart';
import 'package:gender_prediction/presentation/view/widget/custom_button.dart';
import 'package:gender_prediction/presentation/view/widget/custom_textfield.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider<CheckGenderBloc>(
        create: (context) => CheckGenderBloc(
          checkGenderUseCase: locator.get(),
          syncUseCase: locator.get(),
          insertHistoryUseCase: locator.get(),
        )..add(CheckGenderEventInitial()),
        child: BlocConsumer<CheckGenderBloc, CheckGenderState>(
          listener: (context, state) {
            if (state.isSuccess) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) {
                    return ResultPage(gender: state.resultGender);
                  }),
                ),
              );
            }

            if (!state.isValidGender) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) {
                    return const GenderNotFound();
                  }),
                ),
              );
            }
          },
          builder: (context, state) {
            return BlocBuilder<CheckGenderBloc, CheckGenderState>(
              builder: (context, state) {
                bool isLoading = state.isLoading;

                return Align(
                  alignment: Alignment.center,
                  child: isLoading
                      ? _loaderWidget
                      : SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              LottieBuilder.asset(
                                'assets/main_anim.json',
                                width: 300,
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: 300,
                                child: CustomTextField(
                                  hintText: 'Masukkan Nama Pendek',
                                  onChanged: (value) => context
                                      .read<CheckGenderBloc>()
                                      .add(CheckGenderEventInput(name: value)),
                                  keyboardType: TextInputType.text,
                                ),
                              ),
                              !state.isValidInput
                                  ? const Padding(
                                      padding: EdgeInsets.only(top: 20),
                                      child: Text(
                                        'Masukkan nama yang benar!',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    )
                                  : const SizedBox(),
                              const SizedBox(height: 20),
                              state.isValidInput && state.isInitial
                                  ? SizedBox(
                                      width: 300,
                                      child: CustomButton(
                                        label: 'Cek Nama',
                                        colors: Colors.orangeAccent,
                                        onPressed: () => context
                                            .read<CheckGenderBloc>()
                                            .add(CheckGenderEventSubmit()),
                                      ),
                                    )
                                  : const SizedBox(),
                              SizedBox(
                                width: 300,
                                child: CustomButton(
                                    label: 'Pencarian Populer',
                                    colors: Colors.orange,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                const PopulerPage())),
                                      );
                                    }),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget get _loaderWidget {
    return LottieBuilder.asset('assets/searching_anim.json');
  }
}
