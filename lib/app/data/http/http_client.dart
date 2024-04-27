import 'package:dio/dio.dart';

class HttpClient {
  final Dio _dio = Dio(BaseOptions(baseUrl: "http://10.0.2.2:9696"));

  Future<Response> get(String url) async {
    try {
      return await _dio.get(url).then((value) => value);
    } catch (e) {
      throw Exception('Erro ao carregar os dados: $e');
    }
  }

  Future<Response> delete(String url) async {
    try {
      return await _dio.get(url);
    } catch (e) {
      throw Exception('Erro ao carregar os dados: $e');
    }
  }

  Future<Response> patch(String url, Map<String, dynamic> data) async {
    try {
      return await _dio.post(url, queryParameters: data);
    } catch (e) {
      throw Exception('Erro ao enviar os dados: $e');
    }
  }

  Future<Response> patchObject(String url, Map<String, dynamic> data) async {
    try {
      return await _dio.post(url, data: data);
    } catch (e) {
      throw Exception('Erro ao enviar os dados: $e');
    }
  }

  Future<Response> save(String url, Map<String, dynamic> data) async {
    try {
      return await _dio.post(url, data: data);
    } catch (e) {
      throw Exception('Erro ao enviar os dados: $e');
    }
  }
}
