import 'package:dio/dio.dart';
import 'package:fire_guard_app/core/helper/headers_helper.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/resource/url_manager.dart';
import '../../../../../core/service/base_service.dart';

class FireLocationService extends BaseService {
  FireLocationService({required super.dio});

  Future<List<dynamic>> getFireLocation() async {
    try {
      response = await dio.get(
        '$baseUrl/${UrlManager.mobileFireTasksEndpoint}',
        // "https://firegard.cupcoding.com/backend/public/api/mobile/fire-brigade/fires",
        options: Options(
          headers: HeadersHepler.getHeader(),
        ),
      );
      print(response.data['pagination']['items']);
      if (response.statusCode == 200) {
        // print(response.data['data']);
        return response.data['pagination']['items'];
      } else {
        throw ServerException();
      }
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }
}
