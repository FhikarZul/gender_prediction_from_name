import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gender_prediction/injection.dart';
import 'package:gender_prediction/presentation/view/widget/custom_textfield.dart';

import '../../bloc/populer/populer_bloc.dart';

class PopulerPage extends StatelessWidget {
  const PopulerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Nama Populer'),
      ),
      body: BlocProvider<PopulerBloc>(
        create: (context) => PopulerBloc(
          populerNameUseCase: locator.get(),
        )..add(PopulerEventIntial()),
        child: BlocBuilder<PopulerBloc, PopulerState>(
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  color: Colors.orange,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 10,
                      bottom: 5,
                    ),
                    child: CustomTextField(
                      hintText: 'Masukkan Nama',
                      onChanged: (value) => context
                          .read<PopulerBloc>()
                          .add(PopulerEventSearch(name: value)),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ),
                Flexible(
                  child: ListView.builder(
                      itemCount: state.populerNames.length,
                      itemBuilder: ((context, index) {
                        final item = state.populerNames[index];

                        return ListTile(
                          title: Text(item.name),
                          subtitle: Text('${item.count} pencarian'),
                        );
                      })),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
