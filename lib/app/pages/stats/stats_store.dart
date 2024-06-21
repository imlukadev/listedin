import 'package:flutter/material.dart';
import 'package:listedin/app/data/http/http_client.dart';
import 'package:listedin/app/data/model/report.dart';
import 'package:listedin/app/data/model/user.dart';
import 'package:listedin/app/data/repositories/report_repository.dart';

class StatsStore {
  ReportRepository reportRepository = ReportRepository(HttpClient());

  final User user;
  final ValueNotifier<Report?> state = ValueNotifier<Report?>(null);

  Future getReport() async {
    state.value = await reportRepository.getUserStats(user.id!);
  }

  StatsStore(this.user);
}