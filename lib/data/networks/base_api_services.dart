import 'package:flutter/cupertino.dart';

abstract class BaseApiServices {
  Future<dynamic> getApi(String url, dynamic data, BuildContext context);
  Future<dynamic> postApi(payload, url);
  Future<dynamic> updateApi(payload, url);
  Future<dynamic> delete(url);
}
