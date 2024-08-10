import 'package:dio/dio.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/helper/headers_helper.dart';
import '../../../../../core/resource/url_manager.dart';
import '../../../../../core/service/base_service.dart';

class FireNodeService extends BaseService {
  FireNodeService({required super.dio});

  Future<List<dynamic>> getFireNodes() async {
    response = await dio.get(
      '$baseUrl/${UrlManager.mobileFireNodesEndpoint}',
      // "https://firegard.cupcoding.com/backend/public/api/mobile/fire-brigade/task-fire-brigades",
      options: Options(
        headers: HeadersHepler.getHeader(),
      ),
    );

    if (response.statusCode == 200) {
      // print(response.data['pagination']['items']);
      return response.data['pagination']['items'];
    } else {
      throw ServerException();
    }
  }
}