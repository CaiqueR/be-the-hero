import 'package:dio/dio.dart';

class Server {
  static Dio request() => Dio(BaseOptions(
        baseUrl: "http://152.67.61.13:3333",
        connectTimeout: 5000,
        receiveTimeout: 3000,
      ));
}
