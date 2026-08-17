import 'package:digimon/api/app_exceptions.dart';
import 'package:digimon/api/error_handler.dart';
import 'package:digimon/model/digimon_model.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DigimonApi {
  late final Dio _dio;

  DigimonApi() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://digimon-api.vercel.app',
        connectTimeout: const Duration(seconds: 10),
      ),
    );

    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );
  }

  Future<dynamic> _get(String endpoint) async {
    try {
      final response = await _dio.get(endpoint);
      return response.data;
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  Future<List<DigimonModel>> getDigimons() async {
    final data = await _get('/api/digimon');
    return (data as List).map((e) => DigimonModel.fromJson(e)).toList();
  }

  Future<List<DigimonModel>> searchBynameAndLevel(String query) async {
    try {
      final data = await _get('/api/digimon/name/$query');
      return (data as List).map((e) => DigimonModel.fromJson(e)).toList();
    } on NetworkException {
      rethrow;
    } on ServerException {
      rethrow;
    } on NotFoundException {
      try {
        final levelData = await _get('/api/digimon/level/$query');
        return (levelData as List)
            .map((e) => DigimonModel.fromJson(e))
            .toList();
      } on NotFoundException {
        return [];
      } on NetworkException {
        rethrow;
      } on ServerException {
        rethrow;
      }
    }
  }
}
