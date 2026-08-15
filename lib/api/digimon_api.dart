import 'package:digimon/api/api_service.dart';
import 'package:digimon/model/digimon_model.dart';

class DigimonApi {
  final ApiService _apiService;

  DigimonApi(this._apiService);

  Future<List<DigimonModel>> getDigimons() async {
    final data = await _apiService.get('/api/digimon');
    return (data as List).map((e) => DigimonModel.fromJson(e)).toList();
  }

  Future<List<DigimonModel>> searchBynameAndLevel(String query) async {
    try {
      final data = await _apiService.get('/api/digimon/name/$query');
      return (data as List).map((e) => DigimonModel.fromJson(e)).toList();
    } catch (e) {
      final errorMsg = e.toString().toLowerCase();
      if (errorMsg.contains('internet') ||
          errorMsg.contains('network') ||
          errorMsg.contains('timed out') ||
          e.toString().toLowerCase().contains('server')) {
        rethrow;
      }
      try {
        final levelData = await _apiService.get('/api/digimon/level/$query');
        return (levelData as List)
            .map((e) => DigimonModel.fromJson(e))
            .toList();
      } catch (e2) {
        final errorMsg2 = e2.toString().toLowerCase();

        if (errorMsg2.contains('internet') ||
            errorMsg2.contains('network') ||
            errorMsg2.contains('timed out') ||
            e2.toString().toLowerCase().contains('server')) {
          rethrow;
        }

        return [];
      }
    }
  }
}
