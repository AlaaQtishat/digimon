import 'package:digimon/api/api_service.dart';
import 'package:digimon/model/digimon_model.dart';

class DigimonApi {
  final ApiService _apiService;

  DigimonApi(this._apiService);

  Future<List<DigimonModel>> getDigimons() async {
    final data = await _apiService.get('/api/digimon');
    return (data as List).map((e) => DigimonModel.fromJson(e)).toList();
  }
}
