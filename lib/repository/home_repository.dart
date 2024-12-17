import 'package:pembersih_kulkas/data/network/network_api_services.dart';
import 'package:pembersih_kulkas/model/model.dart';

class HomeRepository {
  final _apiServices = NetworkApiServices();
  Future<List<Recipe>> fetchRecipeList() async {
    try {
      dynamic response = await _apiServices.getApiResponse('recipes/complexSearch');
      List<Recipe> result = [];
      if (response['spoonacular']['status']['code'] == 200) {
        result = (response['spoonacular']['results'] as List)
            .map((e) => Recipe.fromJson(e))
            .toList();
      }
      return result;
    } catch (e) {
      rethrow;
    }
    }
}