import 'base_network.dart';
class ApiDataSource {
  static ApiDataSource instance = ApiDataSource();
  Future<Map<String, dynamic>> loadCategory() {
    return BaseNetwork.get("categories.php");
  }

  Future<Map<String, dynamic>> loadMeals(String categoryIN){
    return BaseNetwork.get("filter.php?c=$categoryIN");
  }

  Future<Map<String, dynamic>> loadDetailMeals(String idMealsIN){
    //String id = idMealsIN.toString();
    return BaseNetwork.get("lookup.php?i=$idMealsIN");
  }
}
