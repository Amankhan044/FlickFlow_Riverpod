import 'package:dio/dio.dart';
import 'package:flickflow/data/models/config.dart';
import 'package:get_it/get_it.dart';

class HTTPService {
  final Dio dio = Dio();
  final GetIt getIt = GetIt.instance;

  late String _baseUrl;
  late String _apiKey;

  HTTPService() {
    AppConfig _config = getIt.get<AppConfig>();
    _baseUrl = _config.baseApiUrl;
    _apiKey = _config.apiKey;
  }

  Future<Response> get(String _path,
      {required Map<String, dynamic> query}) async {
    try {
      String _url = "$_baseUrl$_path";
      Map<String, dynamic> _query = {"api_key": _apiKey, "language": "en_US"};

      if (query.isNotEmpty) {
        _query.addAll(query);
      }

      return await dio.get(_url, queryParameters: _query);
    } on DioException catch (e) {
      print("Unable to perform get request");
      print("DioError: $e");

      // Throw the error to indicate failure
      throw Exception("Failed to perform GET request: $e");
    }
  }
}
