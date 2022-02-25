import 'dart:io';

import 'package:aajtak/models/places_model.dart';
import 'package:aajtak/services/api_service_handler.dart';
import 'package:aajtak/utils/api_constants.dart' as api_constants;

import 'base_repository.dart';

class PlacesRepository extends BaseRepository {

  Future<List<Place>> getPlaces(String searchTerm) async {
    try {
      dynamic response = await apiServiceHandler.getOrDeleteDio(
        api_constants.baseUrl,
        endpoint: '/api/location/place',
        queryParams: {'inputPlace':searchTerm},
        requestType: RequestType.GET,
      );

      final placesModel = PlacesModel.fromJson(response);
      return placesModel.data ?? [];
    } catch (e) {
      throw e.toString();
    }
  }

}