import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:listedin/app/data/http/http_client.dart';
import 'package:listedin/app/data/model/File.dart';

abstract class IFileRepository {
  Future<File> getFile();
}

class FileRepository extends IFileRepository {
  final HttpClient client;
  FileRepository(this.client);

  @override
  Future<File> getFile() async {
    Response response = await client.get("/file");
    Map<String, dynamic> body = jsonDecode(response.data);
    return File.fromJson(body);
  }
}
