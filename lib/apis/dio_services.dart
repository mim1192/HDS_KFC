import 'package:dio/dio.dart';
import 'package:hds_ptcl/model/tenat.dart';
import '../model/login_request.dart';
import 'api_response.dart';

class DioService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://172.16.35.28:4279/Multi/api/',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {
      'Content-Type': 'application/json',
      'accept': '*/*',
    },
  ));


  Future<ApiResponse<dynamic>> login(SignIn request) async {
    try {
      final response = await _dio.post(
        'Auth/RiderLogin',
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        return ApiResponse(
          success: true,
          data: response.data, // could be token, map, etc.
          statusCode: response.statusCode,
        );
      } else {
        return ApiResponse(
          success: false,
          message: 'Unexpected status code',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      return ApiResponse(
        success: false,
        message: e.response?.data.toString() ?? e.message,
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'Unexpected error: $e',
      );
    }
  }
  Future<List<TenAt>> fetchTenants() async {
    final Dio dio = Dio();

    try {
      final response = await dio.get('https://your-api-endpoint.com/tenants');

      // If the response is successful (status code 200)
      if (response.statusCode == 200) {
        List<dynamic> data = response.data; // Dio automatically decodes JSON
        return data.map((item) => TenAt.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load tenants');
      }
    } on DioError catch (e) {
      // Handle any Dio-specific errors
      print('DioError: $e');
      throw Exception('Failed to load tenants');
    }
  }
}
