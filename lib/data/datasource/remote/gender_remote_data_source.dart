import 'dart:convert';

import 'package:gender_prediction/data/datasource/remote/api_setting.dart';
import 'package:gender_prediction/data/model/result_model.dart';
import 'package:http/http.dart';

abstract class IGenderRemoteDataSource {
  Future<ResultModel> checkGender({required name});
}

class GenderRemoteDataSource extends IGenderRemoteDataSource {
  final Client httpClient;

  GenderRemoteDataSource({required this.httpClient});

  @override
  Future<ResultModel> checkGender({required name}) async {
    final url = Uri.parse('${ApiSetting.apiUrl}=$name');

    final response = await httpClient.get(url);

    if (response.statusCode == 200) {
      return ResultModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('remote check gender is error.');
    }
  }
}
