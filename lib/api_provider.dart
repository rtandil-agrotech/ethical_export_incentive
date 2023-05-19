import 'package:dio/dio.dart';
import 'package:ethical_export_incentive/models/incentive_model.dart';

class ApiProvider {
  final dio =
      Dio(BaseOptions(baseUrl: 'https://staging-api.primaxcelinovasi.co.id'));

  static const authService = 'auth';
  static const ethService = 'ethical';

  static const loginCredentials = {
    "email": "ricky.kusuma32@gmail.com",
    "password": "P130657",
  };

  Future<Map<String, dynamic>> login() async {
    const url = '/$authService/v1/authentication/login';

    try {
      final response = await dio.post(url, data: loginCredentials);

      final cookieResponse = response.headers["set-cookie"];

      final accessToken = cookieResponse
          ?.firstWhere((element) => element.split("=").first == "AccessToken")
          .split(";")
          .first
          .split("=")[1];

      final refreshToken = cookieResponse
          ?.firstWhere((element) => element.split("=").first == "RefreshToken")
          .split(";")
          .first
          .split("=")[1];

      return {
        'AccessToken': accessToken,
        'RefreshToken': refreshToken,
      };
    } catch (_) {
      throw Exception(_);
    }
  }

  Future<IncentiveModel> getIncentiveStructureFromBackend(
      {required Map<String, dynamic> tokenHeader,
      required DateTime salesPeriod,
      required int salesZoneId,
      required String salesZoneType}) async {
    const url = '/$ethService/v2/incentives';

    final queryParam = {
      "sales_period": (salesPeriod.millisecondsSinceEpoch ~/ 1000),
      "sales_zone_id": salesZoneId,
      "sales_zone_type": salesZoneType,
    };

    final header = {
      "Cookie":
          "AccessToken=${tokenHeader['AccessToken']};RefreshToken=${tokenHeader['RefreshToken']}"
    };

    try {
      final response = await dio.get(url,
          queryParameters: queryParam, options: Options(headers: header));

      if (response.statusCode == 200) {
        if (response.data["message"] == "Success") {
          return IncentiveModel.fromJson(response.data['data']);
        }

        throw Exception(
            "Failed to get response: ${response.data['code']}, ${response.data['status']}");
      }

      throw Exception('Status Code: ${response.statusCode}');
    } on DioError catch (_) {
      throw Exception(_.response?.data);
    } catch (_) {
      throw Exception(_);
    }
  }
}
