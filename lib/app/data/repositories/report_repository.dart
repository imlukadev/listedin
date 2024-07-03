import 'package:dio/dio.dart';
import 'package:listedin/app/data/http/http_client.dart';
import 'package:listedin/app/data/model/report.dart';

abstract class IReportRepository {
  Future<Report> getUserStats(int userId);
}

class ReportRepository extends IReportRepository {
  final HttpClient client;
  ReportRepository(this.client);
  
  @override
  Future<Report> getUserStats(int userId) async {
    try {
      print("to pegando o report");
      Response response = await client.get("/report/user/$userId");
      Map<String, dynamic> report = response.data;
      print(response.data);
      print("response.data");
      return Report.fromJSON(report);
    } catch (e) {
      print(e.toString());  
      throw Exception(e);
    }
  }

}
