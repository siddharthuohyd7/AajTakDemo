import 'dart:io';

import 'package:aajtak/models/relatives_model.dart';
import 'package:aajtak/respository/base_repository.dart';
import 'package:aajtak/services/api_service_handler.dart';
import 'package:aajtak/utils/api_constants.dart' as ApiConstants;


class FriendsRepository extends BaseRepository {
  Future<List<Relative>> getRelatives() async {
    try {
      dynamic response = await apiServiceHandler.getOrDeleteDio(
        ApiConstants.baseUrl,
        endpoint: '/api/relative/all',
        requestType: RequestType.GET,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ' + ApiConstants.authToken,
        },
      );

      final relatives = Relatives.fromJson(response);
      return relatives.data?.allRelatives ?? [];
    } catch (e) {
      throw e.toString();
    }
  }


  Future<dynamic> addRelative(Relative ? relative) async {
    try {
      dynamic response = await apiServiceHandler.postOrPutDio(
        ApiConstants.baseUrl,
        endpoint: '/api/relative',
        requestType: RequestType.POST,
        body: relative?.toJson(),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ' + ApiConstants.authToken,
        },
      );
      return response;
    } catch (e) {
      throw e.toString();
    }
  }
  Future<dynamic> updateRelative(Relative ? relative) async {
    try {
      dynamic response = await apiServiceHandler.postOrPutDio(
        ApiConstants.baseUrl,
        endpoint: '/api/relative/update/${relative?.uuid}',
        requestType: RequestType.POST,
        body: relative?.toJson(),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ' + ApiConstants.authToken,
        },
      );

      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<dynamic> deleteRelative(Relative relative) async {
    try {
      dynamic response = await apiServiceHandler.postOrPutDio(
        ApiConstants.baseUrl,
        endpoint: '/api/relative/delete/${relative.uuid}',
        requestType: RequestType.POST,
        body: relative.toJson(),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ' + ApiConstants.authToken,
        },
      );
      return response;
    } catch (e) {
      throw e.toString();
    }
  }
}
