// ignore_for_file: constant_identifier_names

import 'package:hive/hive.dart';
import 'package:libas_app/core/consts.dart';
import 'package:libas_app/core/errors/exceptions.dart';
import 'package:libas_app/features/grades/domain/grades.dart';

const CASHED_GRADES = 'CASHED_GRADES';
const CASHED_ONE_GRADE = 'CASHED_ONE_GRADE';

class GradesLocalDataSrc {
  var box = Hive.box(Consts.HIVE_BOX_NAME);

  // GradesLocalDataSrc();

  Future<Grades> getGrades() async {
    try {
      final res = box.get(CASHED_GRADES);
      return res;
    } catch (e) {
      throw CacheException();
    }
  }

  Future<void> cacheGrades(Grades grades) async {
    box.put(CASHED_GRADES, grades);
  }

  Future<Grade> getOneGrade(String gradeId) async {
    try {
      final res = box.get(CASHED_ONE_GRADE + '-' + gradeId);
      return res;
    } catch (e) {
      throw CacheException();
    }
  }

  Future<void> cacheOneGrade(Grade grade) async {
    box.put(CASHED_ONE_GRADE + '-' + grade.id, grade);
  }
}
