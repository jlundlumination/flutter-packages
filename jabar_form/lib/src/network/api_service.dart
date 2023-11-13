import 'package:dio/dio.dart';
import 'package:jabar_form/src/network/models/request/submit_request.dart';
import 'package:jabar_form/src/network/models/response/detail_form/detail_form_response.dart';
import 'package:jabar_form/src/network/models/response/submit/submit.dart';

import 'api_endpoint.dart';
import 'rest_connector.dart';

class ApiService {
  Future<DetailFormResponse?> getForm(String slug) async {
    try {
      Response response = await RestConnector(
        requestType: 'GET',
        url: '${ApiEndpoint.baseUrl}surveys/slug/$slug',
      ).call();
      return DetailFormResponse.fromMap(response);
    } on DioException {
      rethrow;
    } catch (e) {
      return null;
    }
  }

  Future<SubmitFormResponse?> submit(SubmitRequest request) async {
    try {
      Response response = await RestConnector(
        requestType: 'POST',
        url: ApiEndpoint.submitSurvey,
        rawJson: request.toJson(),
      ).call();

      return SubmitFormResponse.fromMap(response.data);
    } on DioException {
      rethrow;
    } catch (e) {
      return null;
    }
  }
}