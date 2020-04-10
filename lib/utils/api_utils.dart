import 'dart:convert';
import 'dart:io';

import 'package:cv_projects_task/models/failure_model.dart';
import 'package:cv_projects_task/utils/app_exceptions.dart';
import 'package:http/http.dart' as http;

class ApiUtils {
  /// Returns JSON GET response
  static Future<dynamic> get(String uri,
      {http.Client client, Map<String, String> headers}) async {
    try {
      final response = await client.get(uri, headers: headers);
      final jsonResponse = ApiUtils.jsonResponse(response);
      return jsonResponse;
    } on SocketException {
      throw Failure("No Internet Connection");
    } on HttpException {
      throw Failure("Unable to fetch response");
    }
  }

  /// Returns JSON POST response
  static Future<dynamic> post(String uri,
      {http.Client client, Map<String, String> headers, dynamic body}) async {
    try {
      final response = await client.post(uri, headers: headers, body: body);
      final jsonResponse = ApiUtils.jsonResponse(response);
      return jsonResponse;
    } on SocketException {
      throw Failure("No Internet Connection");
    } on HttpException {
      throw Failure("Unable to fetch response");
    }
  }

  /// Returns JSON PUT response
  static Future<dynamic> put(String uri,
      {http.Client client, Map<String, String> headers, dynamic body}) async {
    try {
      final response = await client.put(uri, headers: headers, body: body);
      final jsonResponse = ApiUtils.jsonResponse(response);
      return jsonResponse;
    } on SocketException {
      throw Failure("No Internet Connection");
    } on HttpException {
      throw Failure("Unable to fetch response");
    }
  }

  /// Returns JSON PATCH response
  static Future<dynamic> patch(String uri,
      {http.Client client, Map<String, String> headers, dynamic body}) async {
    try {
      final response = await client.patch(uri, headers: headers, body: body);
      final jsonResponse = ApiUtils.jsonResponse(response);
      return jsonResponse;
    } on SocketException {
      throw Failure("No Internet Connection");
    } on HttpException {
      throw Failure("Unable to fetch response");
    }
  }

  /// Returns JSON DELETE response
  static Future<dynamic> delete(String uri,
      {Map<String, String> headers}) async {
    try {
      final response = await http.delete(uri, headers: headers);
      final jsonResponse = ApiUtils.jsonResponse(response);
      return jsonResponse;
    } on SocketException {
      throw Failure("No Internet Connection");
    } on HttpException {
      throw Failure("Unable to fetch response");
    }
  }

  static dynamic jsonResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
      case 204:
        var responseJson = json.decode(response.body);
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body);
      case 401:
        throw UnauthorizedException(response.body);
      case 403:
        throw ForbiddenException(response.body);
      case 404:
        throw NotFoundException(response.body);
      case 409:
        throw ConflictException(response.body);
      case 500:
        throw InternalServerErrorException(response.body);
      case 503:
        throw ServiceUnavailableException(response.body);
      default:
        throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}',
        );
    }
  }
}
