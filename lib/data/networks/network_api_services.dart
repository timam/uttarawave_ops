import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:uttarawave_ops/data/app_exceptions/app_exceptions.dart';
import 'package:uttarawave_ops/data/networks/base_api_services.dart';

class NetworkApiService extends BaseApiServices {
  static Future<BaseOptions> getBaseOptions(
      {Map<String, dynamic>? query}) async {
    BaseOptions options = BaseOptions(
        followRedirects: false,
        validateStatus: (status) {
          return status != 401 && status! < 550;
        },
        queryParameters: query,
        baseUrl: '',
        headers: {
          "Accepts": "application/json",
          "Content-type": "application/json",
          "X-Requested-With": "XMLHttpRequest",
        });
    return options;
  }

  @override
  Future delete(url) async {
    Dio dio = Dio(await getBaseOptions());

    dynamic responseJson;

    try {
      final response = await dio.delete(url);

      responseJson = returnResponse(response);
    } catch (e) {
      throw 'Delete Api error : ${e.toString()}';
    }

    return responseJson;
  }

  @override
  Future getApi(String url, data, BuildContext context) async {
    Dio dio = Dio(await getBaseOptions(query: data));

    dynamic responseJson;

    try {
      Response response = await dio.get(url, data: data);
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException();
    } catch (e) {
      throw 'Get Api Error : ${e.toString()}';
    }
    return responseJson;
  }

  @override
  Future postApi(payload, url, context) async {
    Dio dio = Dio(await getBaseOptions());

    dynamic responseJson;

    try {
      final response = await dio.post(url, data: payload);
      responseJson = returnResponse(response);
    } catch (e) {
      throw 'Post Api error : ${e.toString()}';
    }
    return responseJson;
  }

  @override
  Future updateApi(payload, url) async {
    Dio dio = Dio(await getBaseOptions());

    dynamic responseJson;

    try {
      final response = await dio.put(url, data: payload);
      responseJson = returnResponse(response);
    } catch (e) {
      throw 'Update Api error: ${e.toString()}';
    }
    return responseJson;
  }

  dynamic returnResponse(Response response) async {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = response.data;
        return responseJson;
      case 201:
        dynamic responseJson = response.data;
        return responseJson;
      case 400:
        dynamic responseJson = response.data;
        return responseJson;
      case 500:
        dynamic responseJson = response.data;
        return responseJson;
      default:
        throw FetchDataException(
            'Error while communicating with server ${response.statusCode.toString()} ');
    }
  }
}
