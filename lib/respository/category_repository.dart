
import 'package:aajtak/models/category_model.dart';
import 'package:aajtak/respository/base_repository.dart';
import 'package:aajtak/services/api_service_handler.dart';
import 'package:aajtak/utils/api_constants.dart' as api_constants;
class CategoryRepository extends BaseRepository{
  Future<List<Category>> getCategories() async {
    try {
      dynamic response = await apiServiceHandler.getOrDeleteDio(
        api_constants.baseUrl,
        endpoint: '/api/question/category/all',
        requestType: RequestType.GET,
      );

      final model = CategoryModel.fromJson(response);
      return model.data ?? [];
    } catch (e) {
      throw e.toString();
    }
  }
}