import 'dart:developer';

import 'package:dio/dio.dart';

class HttpClient {
  final Dio _dio = Dio(BaseOptions(baseUrl: "http://10.0.2.2:9696"));
    // final Dio _dio = Dio(BaseOptions(baseUrl: "http://127.0.0.1:9696"));

  Future<Response> get(String url) async {
    try {
      return await _dio.get(url).then((value) => value);
    } catch (e) {
      throw Exception('Erro ao carregar os dados: $e');
    }
  }

  Future<Response> delete(String url) async {
    try {

      Response response = await _dio.delete(url);
      return response;

    } catch (e) {
      throw Exception('Erro ao carregar os dados: $e');
    }
  }

  Future<Response> patch(String url, Map<String, dynamic> data) async {
    try {
      return await _dio.patch(url, queryParameters: data);
    } catch (e) {
      throw Exception('Erro ao enviar os dados: $e');
    }
  }

  Future<Response> patchObject(String url, Map<String, dynamic> data) async {
    try {
      return await _dio.patch(url, data: data);
    } catch (e) {
      throw Exception('Erro ao enviar os dados: $e');
    }
  }

    Future<Response> patchLists(String url, List<Map<String, dynamic>> data) async {
    try {
      return await _dio.patch(url, data: data);
    } catch (e) {
      throw Exception('Erro ao enviar os dados: $e');
    }
  }

  Future<Response> save(String url, Map<String, dynamic> data) async {
    try {
      Response response = await _dio.post(url, data: data);
      return response;
    } catch (e) {
      throw Exception('Erro ao enviar os dados: $e');
    }
  }
}
