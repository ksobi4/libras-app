import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:libas_app/core/errors/exceptions.dart';
import 'package:libas_app/core/http_client.dart';
import 'package:libas_app/features/grades/domain/grades.dart';

class GradesRemoteDataSrc {
  HttpClient client;
  GradesRemoteDataSrc({
    required this.client,
  });

  Future<Grades> getGrades() async {
    try {
      Response res = await client.dio
          .post('/grades', options: client.postOptions, data: {});

      if (res.statusCode == 200) {
        return Grades.fromJson(res.data);
      } else {
        throw ServerException(
            messaage: 'Coś poszło nie tak z pobieraniem ocen z serwera');
      }
    } catch (e) {
      log('GET_GRADES ERR = ${e.toString()}');
      throw ServerException(messaage: 'GET_GRADES ERR = ${e.toString()}');
    }
  }

  Future<Grade> getOneGrade(String gradeId) async {
    try {
      Response res = await client.dio.post('/one_grade',
          options: client.postOptions, data: {'grade_id': gradeId});

      if (res.statusCode == 200) {
        return Grade.fromJson(res.data);
      } else {
        throw ServerException();
      }
    } catch (e) {
      log('GET_ONE_GRADE ERR = ${e.toString()}');
      throw ServerException();
    }
  }
}
