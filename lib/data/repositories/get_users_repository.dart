import 'package:dio/dio.dart';
import 'package:random_user_app/core/network/dio_settings.dart';
import 'package:random_user_app/data/models/users_data_model.dart';

import '../models/users_params_model.dart';

class GetUsersRepository {
  final Dio dio = DioSettings().dio;

  Future<UsersDataModel> getUsers({required UsersParamsModel model}) async {
    final Response response = await dio.get(
      '',
      queryParameters: model.toJson(),
    );
    return UsersDataModel.fromJson(response.data);
  }
}
