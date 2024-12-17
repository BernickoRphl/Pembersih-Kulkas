import 'package:flutter/widgets.dart';
import 'package:pembersih_kulkas/model/model.dart';
import 'package:pembersih_kulkas/repository/home_repository.dart';
import 'package:pembersih_kulkas/data/response/api_response.dart';

class HomeViewmodel with ChangeNotifier {
  final _homeRepo = HomeRepository();
  ApiResponse<List<Recipe>> recipeList = ApiResponse.loading();
  bool isLoading = false;
  void setLoading(bool value) {
    isLoading != value;
    notifyListeners();
  }

  setRecipeList(ApiResponse<List<Recipe>> response) {
    recipeList = response;
    notifyListeners();
  }

  Future<void> getRecipeList() async {
    setRecipeList(ApiResponse.loading());
    _homeRepo.fetchRecipeList().then((value) {
      setRecipeList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setRecipeList(ApiResponse.error(error.toString()));
    });
  }
}
