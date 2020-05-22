import 'package:dio/dio.dart';

class Server {
  static Dio request() => Dio(BaseOptions(
        baseUrl: "https://flutter-bethehero.herokuapp.com",
        connectTimeout: 5000,
        receiveTimeout: 3000,
      ));
}
